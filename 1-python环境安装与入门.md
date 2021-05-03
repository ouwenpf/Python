# python环境安装与入门
[资料参考](https://github.com/pyenv/pyenv)  

## 安装pyenv
```
1. 安装
yum install -y patch gdbm-devel openssl-devel sqlite-devel readline-devel zlib-devel bzip2-devel

 yum -y install zlib-devel python-devel libffi-devel tk-devel libpcap-devel bzip2-devel db4-devel xz-devel openssl-devel ncurses-devel patch readline-devel gdbm-devel sqlite-devel


curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	
安装完毕后，在家目录.bash_proflie中加入如下：  

export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

升级:
pyenv update

卸载:
rm -fr ~/.pyenv
删除.bash_proflie如下内容
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```


## 2.pyenv相关命令
```
#[python@pyenv ~]$ pyenv
pyenv 1.2.27
Usage: pyenv <command> [<args>]

Some useful pyenv commands are:
   --version   Display the version of pyenv
   activate    Activate virtual environment
   commands    List all available pyenv commands
   deactivate   Deactivate virtual environment
   doctor      Verify pyenv installation and development tools to build pythons.
   exec        Run an executable with the selected Python version
   global      Set or show the global Python version(s)
   help        Display help for a command
   hooks       List hook scripts for a given pyenv command
   init        Configure the shell environment for pyenv
   install     Install a Python version using python-build
   local       Set or show the local application-specific Python version(s)
   prefix      Display prefix for a Python version
   rehash      Rehash pyenv shims (run this after installing executables)
   root        Display the root directory where versions and shims are kept
   shell       Set or show the shell-specific Python version
   shims       List existing pyenv shims
   uninstall   Uninstall a specific Python version
   version     Show the current Python version(s) and its origin
   version-file   Detect the file that sets the current pyenv version
   version-name   Show the current Python version
   version-origin   Explain how the current Python version is set
   versions    List all Python versions available to pyenv
   virtualenv   Create a Python virtualenv using the pyenv-virtualenv plugin
   virtualenv-delete   Uninstall a specific Python virtualenv
   virtualenv-init   Configure the shell environment for pyenv-virtualenv
   virtualenv-prefix   Display real_prefix for a Python virtualenv version
   virtualenvs   List all Python virtualenvs found in `$PYENV_ROOT/versions/*'.
   whence      List all Python versions that contain the given executable
   which       Display the full path to an executable

See `pyenv help <command>' for information on a specific command.
For full documentation, see: https://github.com/pyenv/pyenv#readme
   
version显示当前的python版本   
versions显示所有可以用的python版本和当前版本   
1. install相关命令(不要使用root用户安装,使用普通用户安装)

pyenv help [commands]: 命令帮助
pyenv install -l: 列出所有python版本
pyenv install 3.6.5 -v: 如安装3.6.5并显示安装过程
在线安装相应的python版本(可能会很慢),为了加速安装，可以使用cache方法离线安装，在.pyenv目录下mkdir cache放入下载好的安装包

2. global命令
pyenv global 3.6.5
pyenv global system调回系统默认python版本
pyenv版本控制窗口中都是3.6.5的python版本了，如果是root用户安装，建议不要使用global，否则影响太大，会带来很多负面的影响 ,所以不建议使用

3. shell命令
pyenv shell 3.6.5
影响只作用于当前会话 ,生产环境用的也比较少

4. local命令
pyenv local 3.6.5
local设置当前目录和该目录下所有子目录,使用pyenv local设置从当前工作目录开始向下递归都继承这个设置 ,包混在一起，包的多版本也混在一起，项目无法拆分，所有需要使用虚拟环境设置
```	

## pyenv的python版本控制,生产环境中所使用

Virtualenv虚拟环境设置  
为什么要用虚拟环境？
因为使用的Python环境都是一个公共的空间，如果多个项目使用不同Python版本开发，或者使用不同的Python版本部署运行，或者使用同样的版本开发的但是不同项目使用了不同的版本库等等这些问题都会带来冲突，无法做到开发环境的隔离和所使用库的隔离，最好的办法就是每一个项目独立运行自己的"独立小环境"中。
```
pyenv  virtualenv 3.6.5  py_learn 用这个版本衍生出一个新的py_learn虚拟的版本
pyenv  local py_learn	 设置目录为新的py_learn虚拟的版本
(py_learn) [python@pyenv py_learn]$ 出现此结果表示创建虚拟环境成功
.pyenv/versions/3.6.5/envs/py_learn/lib/python3.6/site-packages/ 开发中安装所有的包都会安装在此,以后只要使用这个虚拟的版本，包就会安装到这些对应的目录下，而不是使用3.6.5
所以我们要用local+virtualenv来达到版本的隔离,从而达到使用库的隔离.
```  

	
	

	
#### pip通用配置

pip就是Python的包管理工具，3.x的版本直接带了，可以直接使用和域名一样为了使用国内镜像，需做如下配置

	mkdir $HOME/.pip
	vim $HOME/.pip/pip.conf
	[global]
	index-url=https://mirrors.aliyun.com/pypi/simple   
	trusted-host=mirrors.aliyun.com
## https://pypi.doubanio.com/simple如果阿里源打不开使用这个地址
	pip install ipython 
	pip install jupyter 
	jupyter notebook password 设置密码
	jupyter notebook --ip=0.0.0.0 --port=50000 --no-browser /tmp/jupyter.log 2>&1 & 启动默认监听8888端口
	如果是root用户
	jupyter notebook --generate-config --allow-root
	jupyter notebook password 
	jupyter notebook --ip=0.0.0.0 --allow-root > /tmp/jupyter.log 2>&1 &
	
	pip list 查询当前项目所依赖的包
	pip freeze > parckage 导出项目所依赖的开发包
	pip -r parckage		  到对应的项目环境安装相应的开发包即可
	

## 离线安装

可以把克隆目录打包，方便以后离线使用   

	git clone git://github.com/pyenv/pyenv.git  ~/.pyenv
	git clone git://github.com/pyenv/pyenv-doctor.git   ~/.pyenv/plugins/pyenv-doctor
	git clone git://github.com/pyenv/pyenv-installer.git ~/.pyenv/plugins/pyenv-installer
	git clone git://github.com/pyenv/pyenv-update.git	~/.pyenv/plugins/pyenv-update
	git clone git://github.com/pyenv/pyenv-virtualenv.git	~/.pyenv/plugins/pyenv-virtualenv
	git clone git://github.com/pyenv/pyenv-which-ext.git	~/.pyenv/plugins/pyenv-which-ext
	
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
	
