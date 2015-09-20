<?php

/***
 * Library for projects
 * Author: Jens V.
 * Date: 07-09-2015
 ***/

require_once($_SERVER['DOCUMENT_ROOT'] . "/lib/northcode.php");
require_once($_SERVER['DOCUMENT_ROOT'] . "/res/mysql_connect.php");

class Project {

	public $id;
	public $idname;
	public $name;
	public $desc;
	public $created;
	public $git_repo;

	public $tabs;
	public $users;


	/**
	 * Constructor, gets project info
	 * @param $id Integer ID of project or idname
	 */
	public function __construct($id)
	{
		global $mysql;

		if(is_numeric($id))
		{
			$s = 'i';
			$cond = 'id = ?';
		} else {
			$s = 's';
			$cond = 'idname = ?';
		}


		$stmt = $mysql->prepare("SELECT 
			projects.id,
			projects.idname,
			projects.name,
			projects.desc,
			projects.created,
			projects.git_repo
			 FROM projects WHERE $cond");
		echo $mysql->error;
		$stmt->bind_param($s, $id);
		$stmt->execute();
		$stmt->bind_result($this->id, $this->idname, $this->name, $this->desc, $this->created, $this->git_repo);
		$stmt->fetch();
		$stmt->close();


		// Fetch projecttabs
		$this->tabs = array();

		$stmt = $mysql->prepare("SELECT id, title, content, updated FROM project_tabs WHERE pid = ?");
		$stmt->bind_param('i', $this->id);
		$stmt->execute();
		$stmt->bind_result($tid, $ttitle, $tcontent, $tupdated);
		while($stmt->fetch())
		{
			$this->tabs[] = new ProjectTab($tid, $ttitle, $tcontent, $tupdated);
		}
		$stmt->close();


		// Fetch projectcontributors
		$this->users = array();

		$stmt = $mysql->prepare("SELECT id, uid FROM project_contributors WHERE pid = ?");
		$stmt->bind_param('i', $this->id);
		$stmt->bind_result($uid, $uuid);
		$stmt->execute();
		while($stmt->fetch())
		{
			$this->users[] = new ProjectUser($uid, $uuid);
		}
		$stmt->close();

		// TODO: Fetch Usernames!
		// Fetch usernames
		foreach($this->users as $user)
		{
			$user->user = nc_api::get_user_info($user->uid);
		}

	}

	/**
	 * Gets multiple projects more efficiently
	 * @param $ids List of projectid (only integer)
	 */
	public static function getMultipleProjectsById($ids)
	{
		$Projects = array();
		foreach($ids as $pid)
		{
			$Projects[] = new Project($pid);
		}
		return $Projects;
	}

	public static function getMultipleProjectsByCond($cond = "1 = 1")
	{
		global $mysql;

		$pids = array();

		$stmt = $mysql->prepare("SELECT projects.id FROM projects WHERE $cond");
		$stmt->execute();
		$stmt->bind_result($pid);
		while($stmt->fetch())
		{
			$pids[] = $pid;
		}
		$stmt->close();

		return Project::getMultipleProjectsById($pids);
	}

	/**
	 * Gets a list of projects
	 * @param $cond WHERE condition
	 * @param $limit How many projects
	 * @param $start Where to start listing projects (for pagination)
	 */
	public static function listProjects($cond, $limit, $start)
	{

	}

	/**
	 * Creates a project
	 * @param $idname, $name, $desc Parameters for project
	 */
	public static function createProject($idname, $name, $desc)
	{

	}

	/**
	 * Deletes a project
	 * @param $id Id or idname of project
	 */
	public static function deleteProject($id)
	{

	}

	/**
	 * Edits a project
	 * @param $data two dimensional array with key,value pairs of idname, name, desc, git_repo
	 */
	public function editProject($data)
	{

	}

	/**
	 * Adds a tab
	 * @param $tabname Name of tab
	 * @param $text Content
	 */
	public function addTab($tabname, $text)
	{

	}

	/**
	 * Deletes a tab
	 * @param $tabid Id of the tab
	 */
	public function deleteTab($tabid)
	{

	}

	/**
	 * Edits a tab
	 * @param $tabid Id of the tab
	 * @param $text New text
	 */
	public function editTab($tabid, $text)
	{

	}

	/**
	 * Adds a user/creator to the project
	 * @param $uid User id
	 */
	public function addUser($uid)
	{

	}

	/**
	 * Deletes a user/creator from the project
	 * @param $uid User id
	 */
	public function deleteUser($uid)
	{

	}

	/*!*
	 * Edits a user
	 * To be implemented?
	 * e.g. what the user does
	 *!
	public function editUser($uid, $data)
	{
	
	}
	*/

}


class ProjectTab {
	public $id;
	public $title;
	public $content;
	public $updated;

	public function __construct($id, $title, $content, $updated)
	{
		$this->id = $id;
		$this->title = $title;
		$this->content = $content;
		$this->updated = $updated;
	}
}


class ProjectUser {
	public $id;
	public $uid;
	public $user;

	public function __construct($id, $uid)
	{
		$this->id = $id;
		$this->uid = $uid;
	}
}