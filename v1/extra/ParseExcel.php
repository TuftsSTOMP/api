<?php
require_once "vendor/autoload.php";
 
class ChunkReadFilter implements PHPExcel_Reader_IReadFilter {
	private $_startRow = 0;
	private $_endRow = 0;
 
	/** Set the list of rows that we want to read */
	public function setRows($startRow, $chunkSize) {
		$this->_startRow = $startRow;
		$this->_endRow = $startRow + $chunkSize;
	}
 
	public function readCell($column, $row, $worksheetName = '') {
		// Only read the heading row, and the configured rows
		if (($row == 1) || ($row >= $this->_startRow && $row < $this->_endRow)) {
			return true;
		}
		return false;
	}
} 
 
$fileName = "StomperInfo.xlsx";
$sheetname = "Stomper";
 
$excelReader = PHPExcel_IOFactory::createReaderForFile($fileName); 
$excelReader->setLoadSheetsOnly($sheetname);

$chunkSize = 2048;
$chunkFilter = new chunkReadFilter(); 
$excelReader->setReadFilter($chunkFilter);
 

for ($startRow = 2; $startRow <= 300; $startRow += $chunkSize) {

	$chunkFilter->setRows($startRow,$chunkSize);

	$excelObj = $excelReader->load($inputFileName);
	$data = $excelObj->getActiveSheet()->toArray(null, true,true,true);
	echo $startRow . ": " . $data . "/n";
}