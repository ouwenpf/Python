#/bin/bash
#

function_package(){
	if [ `ping 8.8.8.8 -c 5 | grep "min/avg/max" -c` = '1' ]; then
		yum install -y patch gdbm-devel openssl-devel sqlite-devel readline-devel zlib-devel bzip2-devel
		return_value=$?
		return ${return_value}
	else
		echo "The network connection failed and the installation was terminated!"
		exit

	fi
}

function_pyenv(){
	
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash;return_value=$?
	return ${return_value}



}


function_profile(){

	cat >> ~/.bash_profile <<-EOF
	export PATH="~/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
	EOF
	return_value=$?
	. ~/.bash_profile
        return ${return_value}


}

function_pip(){
	
	mkdir -p ~/.pip
	cat > ~/.pip/pip.conf <<-EOF
	[global]
	index-url=https://mirrors.aliyun.com/pypi/simple
	trusted-host=mirrors.aliyun.com
	EOF
	return_value=$?
	return ${return_value}

}


#function_package
function_profile
function_pip
