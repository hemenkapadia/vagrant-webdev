## What is vagrant-webdev ?

vagrant-webdev is a [Vagrant](http://www.vagrantup.com) based development box that can be used to quickly set-up a web development environment.

## What constitutes the development stack ?

The following forms the development stack

1. Ubuntu 14.04 (Trusty Thar) 32 bit base box.  (Referred to as `GUEST` throughout the document)
2. Oracle JDK 7
3. Apache Maven
4. Nodejs and NPM
5. yeoman stack
6. mongodb
7. gradle

## How do I start using vagrant-webdev?

The best part here is that you can use vagrant-webdev on Windows, Mac or any Linux environment, and the steps to do so are exactly the same.

### Step 1. System Set-up

Go ahead and get the following tools installed on your system (Referred to as `HOST` throughout the document) 

1. [Git](http://git-scm.com/downloads)
2. [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
3. [Vagrant](https://www.vagrantup.com/downloads.html)

> Note - If your `HOST` system is Linux or Mac OSX, I strongly recommend you to use [vagrant-webdev-nfs](https://github.com/hemenkapadia/vagrant-webdev-nfs) repository. It uses nfs to overcome performance issues with virtualbox shared folders, used by vagrant-webdev. A Windows `HOST` does not seem to have this issue.

To know more about NFS performance read

1. [Use NFS to speed up your Vagrant ](https://coderwall.com/p/uaohzg)
2. [NFS shared folders](http://friendsofvagrant.github.io/v1/docs/nfs.html)

I also assume a directory structure as follows. So go ahead and create one as mentioned below

	| Your home directory
	|--- projects
	|------ vagrant-webdev-workspace
	|------ vagrant-webdev-m2

> vagrant-webdev-workspace and vagrant-webdev-m2 are important shared folders between your `GUEST` and `HOST`.

> Workspace folder will contain your development code, such that you can use tools that you are comfortable with (IDE, Browser etc.) on your `HOST` for development and testing. The code that you develop will then be built and deployed on the `GUEST` environment.

>M2 folder is your maven repository, needed for dependency resolution in your IDE on `HOST` as well as for building on `GUEST`.

### Step 2. Clone the GitHub repository

Follow these commands to clone the vagrant-webdev repository on the `HOST`

	cd ~
	cd projects
	git clone https://github.com/hemenkapadia/vagrant-webdev.git

This will clone the vagrant-webdev code from GitHub to your `HOST` machine and your directory structure would look like 

	| Your home directory
	|--- projects
	|------ vagrant-webdev-workspace
	|------ vagrant-webdev-m2
	|------ vagrant-webdev

### Step 3. Start the `GUEST` machine

Follow these commands to start the `GUEST` machine as a virtual machine running in your `HOST` environment

	cd ~
	cd projects
	cd vagrant-webdev
	vagrant up
	
This step will take a long time to complete for the first time, so have some patience. 

> For the first time, vagrant will download the Ubuntu base box (approx 300 MB) and provision it. During provisioning, it also downloads the Oracle JDK 7 installer (approx 150 MB) which also takes time depending on your internet connection. Be patient, as long as you do not see any error you should be good.

If the above step completed successfully you have a fully operational web development system ready at your disposal, with all the tools mentioned in the development stack above pre-installed for you.

### Step 4. Connect to the `GUEST` and verify

To connect to your vagrant-webdev development environment issue the command in the vagrant-webdev directory

	vagrant ssh
	
This will open up a SSH session with the `GUEST` and issue you a prompt as shown below

	hekapadi@HEKAPADI-W7-1 ~/Workspaces/Personal/vagrant-webdev (develop)
	$ vagrant ssh
	Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-30-generic i686)

	 * Documentation:  https://help.ubuntu.com/

	 System information disabled due to load higher than 1.0

		Get cloud support with Ubuntu Advantage Cloud Guest:
			http://www.ubuntu.com/business/services/cloud

	0 packages can be updated.
	0 updates are security updates.


	vagrant@vagrant-ubuntu-trusty-32:~$

Notice the change in the prompt. It indicates that you are now on the `GUEST` box.

I use the following commands to ensure vagrant-webdev has been provisioned correctly. Verify once your machine is up too.

	vagrant@vagrant-ubuntu-trusty-32:~$ java -version
	java version "1.7.0_60"
	Java(TM) SE Runtime Environment (build 1.7.0_60-b19)
	Java HotSpot(TM) Client VM (build 24.60-b09, mixed mode)
	vagrant@vagrant-ubuntu-trusty-32:~$ mvn -version
	Apache Maven 3.0.5
	Maven home: /usr/share/maven
	Java version: 1.7.0_60, vendor: Oracle Corporation
	Java home: /usr/lib/jvm/java-7-oracle/jre
	Default locale: en_US, platform encoding: UTF-8
	OS name: "linux", version: "3.13.0-30-generic", arch: "i386", family: "unix"
	vagrant@vagrant-ubuntu-trusty-32:~$ mongod -version
	db version v2.4.10
	Wed Jul  2 17:10:54.326 git version: e3d78955d181e475345ebd60053a4738a4c5268a
	vagrant@vagrant-ubuntu-trusty-32:~$ mongo -version
	MongoDB shell version: 2.4.10
	vagrant@vagrant-ubuntu-trusty-32:~$ node -v
	v0.10.29
	vagrant@vagrant-ubuntu-trusty-32:~$ npm -v
	1.4.14
	vagrant@vagrant-ubuntu-trusty-32:~$ yo -v
	[?] ==========================================================================
	We're constantly looking for ways to make yo better!
	May we anonymously report usage statistics to improve the tool over time?
	More info: https://github.com/yeoman/insight & http://yeoman.io
	==========================================================================: No
	1.2.0
	vagrant@vagrant-ubuntu-trusty-32:~$ env | grep java
	DERBY_HOME=/usr/lib/jvm/java-7-oracle/db
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-7-oracle/bin:/usr/
	lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin
	JAVA_HOME=/usr/lib/jvm/java-7-oracle
	NODE_PATH=/usr/lib/nodejs:/usr/lib/node_modules:/usr/share/javascript
	J2SDKDIR=/usr/lib/jvm/java-7-oracle
	J2REDIR=/usr/lib/jvm/java-7-oracle/jre
	vagrant@vagrant-ubuntu-trusty-32:~$ env | grep maven
	vagrant@vagrant-ubuntu-trusty-32:~$
	
  
## How can I contribute ?

### Branch or Fork ?

The first and foremost requirement to contribute is to have a GitHub account, so as a first step please [register with GitHub](https://github.com/).

> Currently, I do not plan to add other additional features to vagrant-webdev unless it is really value adding. 

As a result of the above guideline, there are two options available for you to contribute.

* __Branch__: If you are planning to fix a bug in the current code or in general improving the way things are implemented, without adding new features, you need to create a Branch. In case you are planning to add new features or packages please do __NOT__ create a Branch, but create a Fork. I discuss branching in more detail below.
* __Fork__: If you intend to use vagrant-webdev as a base and then want to modify it (e.g. remove mongodb and add MySQL) or want to add additional packages, then you need to create a Fork. That way none of the changes you make in your fork move to my repository, but there is a linkage maintained. You can continue working independently on your Fork which is identical to it's parent repository when you forked it.

### Git Flow.

If you are new to Git, then I strongly recommend reading the following in order before you proceed to contribute to the repository.

* [Git Branching chapter](https://www.atlassian.com/git/tutorial/git-branches)
* [Git Workflows chapter](https://www.atlassian.com/git/tutorials/comparing-workflows/)
* [Vincent Driessen's - A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
* [A cheatsheet for Vincent's branching model](http://www.marvinlabs.com/wp-content/uploads/2013/06/git-flow-cheatsheet.pdf)
* [Gitflow 

The branching model suggested by Vincent is excellent and strongly recommended in any Enterprise development scenario. If you are interested in implementing the same I suggest you also read about [git-flow - a plugin that makes it much easier to follow Vincent's approach](http://danielkummer.github.io/git-flow-cheatsheet/)


### GitHub Flow

However for this project (and possibly all my other repositories) I would use only a subset of the workflow suggested by Vincent. 

Read the below two articles completely

* [GitHub flow](https://guides.github.com/introduction/flow/)
* [Comparision of Git flow and GitHub flow](http://nicoespeon.com/en/2013/08/which-git-workflow-for-my-project/)

Our repository will have a single long running branch

* __master__: This is the main branch, and is expected to be extremely stable. This branch will be cloned by most people who would want to start using vagrant-webdev, hence the stability requirement. It is recommended not to push directly to master unless the change is extremely small and you are sure it will not impact anything and have thoroughly tested it. I would still recommend not to push directly to master.

If there is a new feature we would agree to add, then we would create a new feature branch to track that development

* __feature branches__: A single feature branch is created to logically track an individual feature being developed, on which multiple developers could be working. The naming convention to follow for a feature branch is __feature_name__. A single developer can work on more than one feature.

#### GitHub Flow steps

I suggest each developer follow the below process to contribute new features

1. Create a new feature branch locally as well as on the remote (if it does not exists). Creating on remote is very important because you would want to collaborate with others who would want to work on the same feature. Additionally it would also avoid work duplication. Feature branch is created from master.
2. Develop on your local feature branch, and push frequently to the remote feature branch.
3. Periodically monitor any changes made to master after you created the feature branch from master in step 1 above. If there are any changes, merge them to your feature branch.
4. Once feature is complete and tested to be working fine, open a pull request for merging back to master.
5. A code review process will follow.
6. Post successful code review the new feature branch will be merged into master.
7. The feature branch will be deleted on remote, and ideally should be deleted locally too.


That's it. Feel free to participate.
