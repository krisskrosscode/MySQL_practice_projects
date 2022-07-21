<?php

include 'connection-pdo.php';


/**
 * 
 */
class DBHandler extends DBCon
{
	private $insert_query;
	private $select_query;
	private $delete_query;
	private $toggle_query;
	private $update_query;
	private $select_query_id;
	
	function __construct(){
		parent::__construct();
		$this->insert_query = "";
		$this->select_query = "";
		$this->delete_query = "";
		$this->toggle_query = "";
		$this->select_query_id = "";
		$this->update_query = "";
	}

	private function set_insert_query($title, $ytlink){
		$this->insert_query = "INSERT INTO watch_list(title, ylink) VALUES ('$title', '$ytlink');";
	}

	private function set_update_query($id, $title, $ytlink){
		$this->update_query = "UPDATE watch_list SET title='$title', ylink='$ytlink' WHERE id = '$id';";
	}

	private function set_select_query($ytlink){
		if ($ytlink) {
			$this->select_query = "SELECT * FROM watch_list WHERE ylink='$ytlink';";
		} else {
			$this->select_query = "SELECT * FROM watch_list ORDER BY id DESC;";
		}
	}

	private function set_select_query_id($id){
		if ($id) {
			$this->select_query_id = "SELECT * FROM watch_list WHERE id='$id';";
		} else {
			$this->select_query_id = "SELECT * FROM watch_list ORDER BY id DESC;";
		}
	}

	private function set_delete_query($id){
		$this->delete_query = "DELETE FROM watch_list WHERE id = '$id';";
	}

	private function set_toggle_query($id, $toggle_value){
		$this->toggle_query = "UPDATE watch_list SET is_watched = '$toggle_value' WHERE id = '$id';";
	}

	function is_proper_title($title){
		if (preg_match('/^[a-z0-9?.?\-?,?_?]+$/', strtolower($title))) {
			return true;
		}
		return false;
	}

	function is_proper_link($ytlink){
		$reg_exUrl = '%^((https?://)|(www\.))([a-z0-9-].?)+(:[0-9]+)?(/.*)?$%i';
		if (preg_match($reg_exUrl, strtolower($ytlink))) {
			return true;
		}
		return false;
	}

	public function delete_data($id){
		if (!is_numeric($id)) {
			$msgbox = array('code' => '0', 'msg' => 'Invalid Parameter!');
            return json_encode($msgbox);
		}

		try {
			
			$this->set_delete_query($id);

	        $query  = $this->pdoconn->prepare($this->delete_query);
	        
	        if ($query->execute()) {
	        	$msgbox = array('code' => '1', 'msg' => 'Record deleted successfully!');
            	return json_encode($msgbox);
	        } else {
	        	$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            	return json_encode($msgbox);
	        }
	        
	    } catch (Exception $e) {
			$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            return json_encode($msgbox);
		}
	}

	private function find_toggle_value($id){
		try {
			$sql = "SELECT is_watched FROM `watch_list` WHERE id='$id';";
			$query  = $this->pdoconn->prepare($sql);

			if($query->execute()){

				$arr = $query->fetchAll(PDO::FETCH_ASSOC);

				return array('code' => '1', 'val' => $arr[0]['is_watched']);

			} else {
				return array('code' => '0', 'val' => 'Error!');
			}
		} catch (Exception $e) {
			return array('code' => '0', 'val' => 'Error!');
		}
	}

	public function toggle_data($id){
		if (!is_numeric($id)) {
			$msgbox = array('code' => '0', 'msg' => 'Invalid Parameter!');
            return json_encode($msgbox);
		}

		try {

			if ($this->find_toggle_value($id)['code'] == '1') {

				$value = $this->find_toggle_value($id)['val'];

			} else {

				$msgbox = array('code' => '0', 'msg' => 'No such record exists!');
            	return json_encode($msgbox);
			}

			if ($value == '0') {
				$value = '1';
			} else {
				$value = '0';
			}
			
			$this->set_toggle_query($id, $value);

	        $query  = $this->pdoconn->prepare($this->toggle_query);
	        
	        if ($query->execute()) {

	        	$msgbox = array('code' => '1', 'msg' => 'Record toggled successfully!');
            	return json_encode($msgbox);
	        } else {
	        	$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            	return json_encode($msgbox);
	        }
	        
	    } catch (Exception $e) {
			$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            return json_encode($msgbox);
		}


	}

	public function fetch_data(){

		try {
			
			$this->set_select_query(false);

	        $query  = $this->pdoconn->prepare($this->select_query);
	        $query->execute();
	        $arr = $query->fetchAll(PDO::FETCH_ASSOC);
	        return $arr;
	    } catch (Exception $e) {
			$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            return json_encode($msgbox);
		}
	}

	public function edit_data($id){
		try {
			
			$this->set_select_query_id($id);

	        $query  = $this->pdoconn->prepare($this->select_query_id);
	        $query->execute();
	        $arr = $query->fetchAll(PDO::FETCH_ASSOC);
	        return $arr;
	    } catch (Exception $e) {
			$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            return json_encode($msgbox);
		}
	}

	public function update_data($id, $title, $ytlink){
		if (!is_numeric($id)) {
			$msgbox = array('code' => '0', 'msg' => 'Invalid Parameter!');
            return json_encode($msgbox);
		}


		try {
			
			$this->set_select_query_id($id);

	        $query  = $this->pdoconn->prepare($this->select_query_id);
	        $query->execute();
	        $arr = $query->fetchAll(PDO::FETCH_ASSOC);
	        if(count($arr) <= 0){
	        	$msgbox = array('code' => '0', 'msg' => 'No such record exists!');
            	return json_encode($msgbox);
	        }

	        $this->set_update_query($id, $title, $ytlink);
	        $query  = $this->pdoconn->prepare($this->update_query);

	        if($query->execute()){
	        	$msgbox = array('code' => '1', 'msg' => 'Record updated successfully!');
            	return json_encode($msgbox);
	        } else {
	        	$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            	return json_encode($msgbox);
	        }

	    } catch (Exception $e) {
			$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            return json_encode($msgbox);
		}
	}


	public function insert_data($title, $ytlink){

		// if (!$this->is_proper_title($title)) {
		// 	$msgbox = array('code' => '0', 'msg' => 'Invalid Title!');
  //           return json_encode($msgbox);
		// }

		// if (!$this->is_proper_link($ytlink)) {
		// 	$msgbox = array('code' => '0', 'msg' => 'Invalid Youtube Link!');
  //           return json_encode($msgbox);
		// }

		try {

			$this->set_select_query($ytlink);

	        $query  = $this->pdoconn->prepare($this->select_query);
	        $query->execute();
	        $arr = $query->fetchAll(PDO::FETCH_ASSOC);

	        if(count($arr)>0)
	        {
	            $msgbox = array('code' => '0', 'msg' => 'Duplicate Entry!');
	            return json_encode($msgbox);
	        }


	        $this->set_insert_query($title, $ytlink);

	        $query  = $this->pdoconn->prepare($this->insert_query);

	        if($query->execute()){
	        	$msgbox = array('code' => '1', 'msg' => 'Data inserted successfully!');
            	return json_encode($msgbox);
	        } else {
	        	$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            	return json_encode($msgbox);
	        }
	        

	    } catch (Exception $e) {
			$msgbox = array('code' => '0', 'msg' => 'Oops! Something went wrong in the server!');
            return json_encode($msgbox);
		}

	}
}

?>