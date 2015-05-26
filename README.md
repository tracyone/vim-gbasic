# A plugin for gbasic language

`basic`语言变种**gbasic**，用于GoDB架构中，目前唯一知道的，使用这种语言的就是TI IPNC的网页。开发基于`GoDB`架构的网页，使用的是`gStudio`集成环境，但是这个ide非常不好用，搜索什么都非常麻烦，于是乎只能用vim来编辑，但是vim只认`basic`不认`gbasic`这种奇葩语言,所以语法高亮惨不忍睹。

最近较为深入的学习
- `C Language`
- `Vim Script`
- `Regluar Expression`
- `git`

加上`gbasic`在vim中的种种不协调，所以我产生写这样的一个插件的想法，又刚好和《[Learn Vimscript the Hard Way](https://leanpub.com/learnvimscriptthehardway)》一书最后实战的例子类似（里面是为[potion](https://github.com/perl11/potion)语言写这样的一个插件)，所以动手写，并使用`git`+`github`的方式来管理源码，这个插件用到`Vim Script`和`Regluar Expression`，刚好达到练习的目的，一举多得，不过恐怕我以后都不会再碰这语言了，但还是希望它能给有需要的朋友带来帮助。

# 功能特点

- 提供正确语法显示。
- 提供正确的折叠
- 准确section移动，也就是按下`]]`,`[[`,`[]`和`][`的动作。
- `matchit`，扩展`%`键
- 一些外部命令用于工程相关文件的生成。

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

# 配置

## 选项

## 快捷键

## 配置示例

# 致谢








