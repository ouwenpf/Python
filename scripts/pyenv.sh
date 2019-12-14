#/bin/bash
#

[ $# -ne 1 ] && echo 'please enter user name' && exit

def_package(){
	if [ `ping 8.8.8.8 -c 5 | grep "min/avg/max" -c` = '1' -a "$USER" == "root" ]; then
		if ! command -v wget &>/dev/null;then
			yum install wget -y
		fi
			
		wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
		wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
		yum install -y patch gdbm-devel openssl-devel sqlite-devel readline-devel zlib-devel bzip2-devel
		return_value=$?
		return ${return_value}
	else
		echo "The network connection failed and the installation was terminated!"
		exit

	fi
}


def_pyuser(){
	if ! id $1 &>/dev/null;then
		useradd $1
	fi
	
}

###Running under normal users:强烈建议在普通用户下运行

def_pyenv(){
	
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	return_value=$?
	return ${return_value}
}


def_profile(){

	cat >> ~/.bash_profile <<-EOF
	export PATH=\$HOME/.pyenv/bin:\$PATH
	eval "\$(pyenv init -)"
	eval "\$(pyenv virtualenv-init -)"
	EOF
	return_value=$?
	. $HOME/.bash_profile
        return ${return_value}
}

def_pip_conf(){
	
	mkdir -p $HOME/.pip
	cat > $HOME/.pip/pip.conf <<-EOF
	[global]
	index-url=https://mirrors.aliyun.com/pypi/simple
	trusted-host=mirrors.aliyun.com
	EOF
	return_value=$?
	return ${return_value}
}


def_package
def_pyuser $1
#def_pyenv
#def_profile
#def_pip_conf


