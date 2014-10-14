gitrocious
==========

Ruby authorization layer for git.

#Requirements
1.  Must be running a linux variant(has currently been tested with Ubuntu 12.04 and 14.04).
2.  Must have linux user account, usually set up as git or gitrocious and they must have ssh key access to the server.
3.  Must be running ruby 2.0 or newer, rvm is allowed.

#Installation
	
1. Log in to the server as "git" then
```
    git clone https://github.com/Notsew/gitrocious.git
    cd gitrocious && bundle install && rake gitrocious:setup
```

The setup rake will create the admin for gitrocious, run the migrations, and start the production server.  Gitrocious uses puma as the app server, there is a puma config file in the config folder.  Make updates to this file as you see fit.

It is up to you if you want to setup Nginx or Apache to host gitrocious.  Note, if you decide to host publicly, I highly recommend an HTTPS connection.  You can leave it as the puma server and hit it by IP address.  Technically the Gitrocious site doesn't need to be run for this to work.  You can run rails c -e production and add Users, Repos, Permissions, and  SSH Keys through the command line.

#Usage

Gitrocious uses Ruby on Rails as an administration site and allows users without access to download the branches.  Note that users without access can still clone the repos, but they won't be able to push unless they are given access.

In the admin site, you have the ability to create users, groups, repos, permissions, and SSH keys.  When you create a repo it is created under the folder you specified in the setup process(usually /home/git/repos) as a bare repository.

You can give both users and groups permissions to repos.  When you give someone permission to the repo, it is to a branch or tag, and it is always read/write.  You can specify that groups or users can have access to all branches/tags, by setting the branch in the Permission Create Page to "all".

You can also upload custom hooks to each repo, that way you can tie it into continuous integration servers or do other logging, etc.

When someone wants to clone a repository, they will run the following command:
```
git clone <linuxuser>@<host>:<repo name without .get extension>
Example:
git clone git@mydomain.com:project1
```

The user can clone and do local development without issue, permissions will be checked when they attempt to push their changes up.  If the user does not have access then the push will be rejected.

#Notes
If there are any issues during setup with the migrations, please run 
```
rake db:schema:load RAILS_ENV=production
```