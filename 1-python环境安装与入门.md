# python环境安装与入门
[资料参考](https://github.com/pyenv/pyenv)  

## 1.安装pyenv

	yum install -y patch gdbm-devel openssl-devel sqlite-devel readline-devel zlib-devel bzip2-devel
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	
安装完毕后，在家目录.bash_proflie中加入如下：  

	export PATH="~/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"


## 2.pyenv相关命令

	pyenv help command命令帮助
	pyenv install -l 列出所有python版本
	pyenv install 3.6.5 -v
在线安装相应的python版本(可能会很慢),为了加速安装，可以使用cache方法离线安装，在.pyenv目录下mkdir cache放入下载好的安装包
	
### pyenv的python版本控制

version显示当前的python版本   
versions显示所有可以用的python版本和当前版本   

#### global全局设置

	pyenv global 3.6.5
可以看到所有受pyenv版本控制窗口中都是3.6.5的python版本了，如果是root用户安装，建议不要使用global，否则影响太大，会带来很多负面的影响  

	pyenv global system调回系统默认python版本

#### shell会话设置

影响只作用于当前会话   

	pyenv shell 3.6.5
生产环境用的也比较少

#### local本地设置

使用pyenv local设置从当前工作目录开始向下递归都继承这个设置  

	pyenv local 3.6.5  
包混在一起，包的多版本也混在一起，项目无法拆分，所有需要使用虚拟环境设置

### Virtualenv虚拟环境设置

为什么要用虚拟环境？
因为使用的Python环境都是一个公共的空间，如果多个项目使用不同Python版本开发，或者使用不同的Python版本部署运行，或者使用同样的版本开发的但是不同项目使用了不同的版本库等等这些问题都会带来冲突，无法做到开发环境的隔离和所使用库的隔离，最好的办法就是每一个项目独立运行自己的"独立小环境"中。

	pyenv  virtualenv 3.6.5  new36
	pyenv  local new36
	(new36) [python@python web]
真实的目录在~/.pyenv/versions/下，以后只要使用这个虚拟的版本，包就会安装到这些对应的目录下，而不是使用3.6.5
	
#### pip通用配置

pip就是Python的包管理工具，3.x的版本直接带了，可以直接使用和域名一样为了使用国内镜像，需做如下配置

	mkdir ~/.pip
	vim ~/.pip/pip.conf
	[global]
	index-url=https://mirrors.aliyun.com/pypi/simple
	trusted-host=mirrors.aliyun.com

	pip install ipython 
	pip install jupyter 
	jupyter notebook --ip=0.0.0.0 --no-browser启动默认监听8888端口
	如果是root用户
	jupyter notebook --generate-config --allow-root
	jupyter notebook password
	jupyter notebook --ip=0.0.0.0 --allow-root > /tmp/jupyter.log 2>&1 &
	
	pip freeze > parckage 导出项目所依赖的开发包
	pip -r parckage		  到对应的项目环境安装相应的开发包即可
	

## 离线安装

可以把克隆目录打包，方便以后离线使用   

	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	git clone https://github.com/pyenv/pyenv-doctor.git ~/.pyenv/plugins/pyenv-doctor
	git clone https://github.com/pyenv/pyenv-installer.git ~/.pyenv/plugins/pyenv-installer
	git clone https://github.com/pyenv/pyenv-update.git	~/.pyenv/plugins/pyenv-update
	git clone https://github.com/pyenv/pyenv-virtualenv.git	~/.pyenv/plugins/pyenv-virtualenv
	git clone https://github.com/pyenv/pyenv-which-ext.git	~/.pyenv/plugins/pyenv-which-ext
	
只需要配置如下即可   

	vim ~/.bash_profile
	export PATH="~/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
	
	source .bash_profile
	
## 其它
[pip安装低于2.7.9](https://pypi.org/project/pip/)  

	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python get-pip.py