<?php

	require_once dirname(__FILE__). "/../../vendor/autoload.php";

	$inputFileType 	= 'Excel2007';
	$inputFileName 	= "Stomp Master Data.xlsx";
	$outputFileName = "generatedDataInitializationScript.sql";
	

	/**  Define a Read Filter class implementing PHPExcel_Reader_IReadFilter  */ 
	class MyReadFilter implements PHPExcel_Reader_IReadFilter { 
    	private $_columns  = array(); 

    	/**  Get the list of rows and columns to read  */ 
    	public function __construct($columns) { 
        	$this->_startRow = 2;
        	$this->_columns  = $columns; 
    	} 

    	public function readCell($column, $row, $worksheetName = '') { 
     	   //  Only read the rows and columns that were configured 
        	if ($row >= $this->_startRow) { 
            	if (in_array($column,$this->_columns)) { 
                	return true; 
            	} 
        	}
        	//} 
        	return false; 
    	} 
	}

	/**  Create a new Reader of the type defined in $inputFileType  **/
	$objReader = PHPExcel_IOFactory::createReader($inputFileType);


	$sqlFile = fopen($outputFileName, "w") or die("Unable to open file!");
	$text = "
		USE Stomp_test;\n\n\n
		DELETE FROM Transaction;
		DELETE FROM Material;
		DELETE FROM Stomper_Team;
		DELETE FROM Team;
		DELETE FROM Class;
		DELETE FROM Stomper;
		DELETE FROM Teacher;
		DELETE FROM School;\n\n";
	fwrite($sqlFile, $text);


	loadSchools($objReader, $inputFileName, $sqlFile);
	loadTeachers($objReader, $inputFileName, $sqlFile);
	loadStompers($objReader, $inputFileName, $sqlFile);

	loadPairings($objReader, $inputFileName, $sqlFile);

	fclose($sqlFile);



	/*
		loadSchools
		Read the schools from the excel file and load them into sql script
	*/
	function loadSchools($objReader, $inputFileName, $sqlFile) {
		/**  Tell the Reader that we want to use the Read Filter  **/ 
		$objReader->setReadFilter(new MyReadFilter(range('A','E'))); 
		$objReader->setLoadSheetsOnly("Schools"); 

		/**  Load $inputFileName to a PHPExcel Object  **/
		$objPHPExcel = $objReader->load($inputFileName);
		$sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);

		fwrite($sqlFile, "ALTER TABLE School AUTO_INCREMENT = 1;\n");
		array_shift($sheetData); // Remove first element 
		foreach($sheetData as $rowData) {
			$text = "CALL newSchool('".$rowData["A"].
					"','".$rowData["B"].
					"','".$rowData["C"].
					"',".str_replace("\"", "", $rowData["D"]).
					",".$rowData["E"].");\n";
			fwrite($sqlFile, $text);	
		}
	} 



	/* 	
		loadTeachers
		Read the schools from the excel file and load them into sql script
	*/
	function loadTeachers($objReader, $inputFileName, $sqlFile) {
		/**  Tell the Reader that we want to use the Read Filter  **/ 
		$objReader->setReadFilter(new MyReadFilter(range('A','D'))); 
		$objReader->setLoadSheetsOnly("Teachers"); 

		/**  Load $inputFileName to a PHPExcel Object  **/
		$objPHPExcel = $objReader->load($inputFileName);
		$sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);

		fwrite($sqlFile, "\n\nALTER TABLE Teacher AUTO_INCREMENT = 1;\n");
		array_shift($sheetData); // Remove first element 
		foreach($sheetData as $rowData) {
			$text = "CALL newTeacher('".$rowData["A"].
					"','".$rowData["B"].
					"','".$rowData["C"].
					"','".$rowData["D"]."');\n";
			fwrite($sqlFile, $text);	
		}
	} 


	/* 	
		loadStompers
		Read the stompers from the excel file and load them into sql script
	*/
	function loadStompers($objReader, $inputFileName, $sqlFile) {
		/**  Tell the Reader that we want to use the Read Filter  **/ 
		$objReader->setReadFilter(new MyReadFilter(range('A','D'))); 
		$objReader->setLoadSheetsOnly("Stompers"); 

		/**  Load $inputFileName to a PHPExcel Object  **/
		$objPHPExcel = $objReader->load($inputFileName);
		$sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);

		fwrite($sqlFile, "\n\nALTER TABLE Stomper AUTO_INCREMENT = 1;\n");
		array_shift($sheetData); // Remove first element 
		foreach($sheetData as $rowData) {
			$text = "CALL newStomper('".$rowData["A"].
					"','".$rowData["B"].
					"','".$rowData["C"].
					"','".$rowData["D"]."');\n";
			fwrite($sqlFile, $text);	
		}
	}


	/* 	
		loadPairings
		Read the pairings from the excel file and load them into sql script
	*/
	function loadPairings($objReader, $inputFileName, $sqlFile) {
		/**  Tell the Reader that we want to use the Read Filter  **/ 
		$objReader->setReadFilter(new MyReadFilter(range('A','I'))); 
		$objReader->setLoadSheetsOnly("Pairings"); 

		/**  Load $inputFileName to a PHPExcel Object  **/
		$objPHPExcel = $objReader->load($inputFileName);
		$sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);

		fwrite($sqlFile, "\n\nALTER TABLE Class AUTO_INCREMENT = 1;\n");
		fwrite($sqlFile, "ALTER TABLE Team AUTO_INCREMENT = 1;\n");
		fwrite($sqlFile, "ALTER TABLE Stomper_Team AUTO_INCREMENT = 1;\n");


		array_shift($sheetData); // Remove first element 
		foreach($sheetData as $rowData) {
			if($rowData["A"] == '') continue; // skip if empty for some reason
			//new class
			$text = "CALL newClass('".$rowData["E"].
					"','".$rowData["D"].
					"','".$rowData["C"].
					"',".$rowData["B"].");\n";
			fwrite($sqlFile, $text);

			//new team
			$text = "CALL newTeam('".$rowData["E"].
					"','".$rowData["C"]."');\n";
			fwrite($sqlFile, $text);

			//stomperTeam member1
			$fullName = explode(" ", $rowData["F"]);
			$text = "CALL newStomperTeam('".
					$fullName[0]. 
				"', '".$fullName[1].
				"', '".$rowData["E"].
					"','".$rowData["C"]."');\n";
			fwrite($sqlFile, $text);

			//stomperTeam member2
			$fullName = explode(" ", $rowData["G"]);
			$text = "CALL newStomperTeam('".
					$fullName[0]. 
				"', '".$fullName[1].
				"', '".$rowData["E"].
					"','".$rowData["C"]."');\n";
			fwrite($sqlFile, $text);
		}
	}


?>
