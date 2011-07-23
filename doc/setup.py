from os import system

# Exciting stuff!
def linux():
    apt("build-essential")
    apt("git-core")
    apt("ruby")
    apt("ruby1.8-dev")
    apt("irb")
    apt("sqlite3")
    apt("libxslt-dev")
    apt("libxslt-ruby")
    apt("rubygems")
    both()

def mac():
    mac_check_install_homebrew()
    both()

def both():
    gem("rails")
    gem("sqlite3-ruby")
    gem("mongrel")
    gem("nokogiri")

# Boring stuff.
def main():
    if os.uname()[0] is "Linux":
        linux()
    if os.uname()[0] is "Darwin":
        mac()
    if os.uname()[0] is "Windows":
        print "Windows is not currently supported."
        print "Have you accepted Linus Torvalds as your personal Lord and Saviour yet?"

def apt(package):
    system("sudo aptitude install ", package)

def brew(package):
    if package is "mercurial":
        system("brew install python")
	system("brew install pip")
	system("pip install mercurial")
    else:
	system("brew install ", package)

def gem(pkg):
  system("sudo gem install ", pkg, " --no-ri --no-rdoc")

def mac_check_install_homebrew():
    print "Checking to see if you have Homebrew installed"
    if sytem("brew -v") == 0:
        print "Yup, you've got Homebrew installed"
    else:
        print "You haven't got Homebrew installed. We'll just install that."
        system("ruby -e \"$(curl -fsS http://gist.github.com/raw/323731/install_homebrew.rb)\"")
        print "...Phew. That was a lot of work!"
        print "You should now have Homebrew. Follow the instuctions above,"
        print "then rerun this setup script. ;-)"

if __name__ == "main":
    main()
