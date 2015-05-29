
- [A plugin for gbasic language](#A_plugin_for_gbasic_language)
- [功能特点](#功能特点)
- [安装](#安装)
	- [vundle](#vundle)
	- [vim-plug](#vim-plug)
- [截图](#截图)
- [TODO](#todo)
- [致谢](#致谢)

# A plugin for gbasic language

`basic`语言变种**gbasic**，用于GoDB架构中，目前唯一知道的，使用这种语言的就是TI IPNC的网页。开发基于`GoDB`架构的网页，使用的是`gStudio`集成环境，但是这个ide非常不好用，搜索什么都非常麻烦，于是乎只能用vim来编辑，但是vim只认`basic`不认`gbasic`这种奇葩语言,所以语法高亮惨不忍睹。

最近较为深入的学习
- `C Language`
- `Vim Script`
- `Regluar Expression`
- `git`

加上`gbasic`在vim中的种种不协调，所以我产生写这样的一个插件的想法，又刚好和《[Learn Vimscript the Hard Way](https://leanpub.com/learnvimscriptthehardway)》一书最后实战的例子类似（里面是为[potion](https://github.com/perl11/potion)语言写这样的一个插件,很明显这个插件多了一些功能)，所以动手写，并使用`git`+`github`的方式来管理源码，这个插件用到`Vim Script`和`Regluar Expression`，刚好达到练习的目的，一举多得。然而它并没有什么卵用，因为我估计在也不会碰这个语言了，而且它实在是太冷门了，不过还是希望它能够给有需要的朋友带来帮助。

# 功能特点

- 提供正确语法显示，包括关键字，bulidin函数,注释，强调注释,TODO注释
- 提供正确的折叠;
- 准确section移动，也就是按下`]]`,`[[`,`[]`和`][`的动作;
- `matchit`，扩展`%`键;

# 安装

## vundle

在你的`.vimrc`加入下面一句，然后重新source你的`.vimrc`，然后执行`:BundleInstall`

```vim
Bundle "tracyone/gbasic"
```

## vim-plug

在你的`.vimrc`加入下面一句，然后重新source你的`.vimrc`，然后执行`:PlugInstall`

```vim
Plug "tracyone/gbasic"
```

# 截图

**语法高亮**

![syntax1](https://cloud.githubusercontent.com/assets/4246425/7880998/4856d2de-0631-11e5-96a2-6bc1871f90c4.png)

**折叠**

![fold](https://cloud.githubusercontent.com/assets/4246425/7881044/a489fa72-0631-11e5-81b9-5cc1d929f9e7.png)

**matchit**

![matchit](https://cloud.githubusercontent.com/assets/4246425/7881178/ba9d973c-0632-11e5-8171-d47751decb43.gif)

**section移动**

![section](https://cloud.githubusercontent.com/assets/4246425/7881242/6c02a0bc-0633-11e5-8fbf-df9d1f422dfb.gif)

#TODO

- 修改文件时，某些情况下折叠不能正确显示
- 语法高亮似乎由于正则写得比较差还是内置函数太多导致偶尔导致变慢
- 和`basic`语言的源文件一样的后缀(`*.bas`)，应该如何选择来决定`filetype`类型
- 实在想不出这种语言的插件还应该添加什么功能了，编译器相关又不行（没有命令行接口）

# 致谢

感谢发明正则表达式感谢创造Vim编辑器的人们......








