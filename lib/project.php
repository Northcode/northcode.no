<?php

/***
 * Library for projects
 * Author: Jens V.
 * Date: 07-09-2015
 ***/


class Project {

	public $id;
	public $idname;
	public $name;
	public $desc;
	public $created;
	public $git_repo;

	public $type;
	public $type_name;

	public $stage;
	public $stage_name;

	public function __construct($id)
	{
		
	}

}