# 本地重定向

## 本地搭建代理服务器

搭建一个代理服务器的步骤取决于你希望使用的技术栈。以下是使用Node.js和http-proxy-middleware库搭建一个基本的反向代理服务器的步骤：

**步骤1：** 安装Node.js

首先，你需要在你的计算机上安装Node.js。你可以在Node.js的官方网站下载并安装它：https://nodejs.org/

**步骤2：** 创建一个新的Node.js项目

在你的命令行中，创建一个新的目录并进入该目录，然后运行以下命令来创建一个新的Node.js项目：

```bash
mkdir proxy-server
cd proxy-server
npm init -y
```

**步骤3：** 安装http-proxy-middleware

在你的Node.js项目中，运行以下命令来安装http-proxy-middleware库：

```bash
npm install --save http-proxy-middleware
npm install --save express
```

**步骤4：** 创建一个代理服务器

在你的项目中，创建一个新的JavaScript文件（例如，`server.js`），然后添加以下代码：

```javascript
const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();

app.use(
  '/',
  createProxyMiddleware({
    target: 'https://auth.particle.network', // 这里填写你想要代理的目标服务器地址
    changeOrigin: true,
    secure: false, // 如果你要代理的服务器使用的是自签名证书，这个选项需要设置为false
  })
);

app.listen(3000);
```

这个代码会创建一个监听在3000端口的代理服务器，所有发送到这个服务器的请求都会被转发到`https://auth.particle.network`。

**步骤5：** 启动代理服务器

在你的命令行中，运行以下命令来启动你的代理服务器：

```bash
node server.js
```

现在，你的代理服务器应该正在运行，并且会将所有的请求转发到`https://auth.particle.network`。

请注意，这个示例非常基本，仅用于演示如何设置一个简单的代理服务器。在实际使用中，你可能需要根据你的具体需求进行更多的配置，例如处理HTTPS连接、添加身份验证、处理特定的HTTP方法等。

## HOOK SFSafariViewController

参考 Demo 中的 SFSafariViewController+My 文件
