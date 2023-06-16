# pi-admin

## 简介

pi-admin 是基于 Spring Boot 2.7.12、MyBatis-Plus、Spring Security 等主流技术栈构建的后台管理系统。

### 特性

- 基于 Spring Security、JWT 的统一认证鉴权。
- 使用 MyBatis-Plus 简化 DAO 操作，它提供了众多插件，如自动分页、逻辑删除、自动填充、多租户等。
- 整合 Flowable 工作流，方便管理、执行和监控复杂的工作流和业务流程。
- 内置多租户，方便隔离不同企业、分公司、组织的数据。
- 数据权限。自定义 MyBatis-Plus  的拦截器拦截待执行的 SQL，动态添加查询条件，实现数据过滤。
- 数据脱敏。采用自定义 Jackson 序列化器在序列化时脱敏。只需一个注解，指定脱敏策略即可实现数据脱敏。
- 支持 Docker 编排，一键部署环境。
- 代码风格遵循 Alibaba Java 开发规范。
- 只保留系统核心功能，无过度自定义封装，易于学习和功能扩展。

### 系统演示

系统演示请访问：https://jiabin.williamalec.top/

### 源码

#### pi-admin 前后端分离框架

[文档跳转](https://gitee.com/linjiabin100/pi-admin/wikis/pages)

|      | Gitee                                           | GitHub                                     |
| ---- | ----------------------------------------------- | ------------------------------------------ |
| 后端 | https://gitee.com/linjiabin100/pi-admin.git     | https://github.com/zengpi/pi-admin.git     |
| 前端 | https://gitee.com/linjiabin100/pi-admin-web.git | https://github.com/zengpi/pi-admin-web.git |

#### pi-cloud 微服务框架

[文档跳转](https://www.yuque.com/zengpi/szfuh0)

| Gitee | GitHub                                          |                                                              |
| ----- | ----------------------------------------------- | ------------------------------------------------------------ |
| 后端  | https://gitee.com/linjiabin100/pi-cloud.git     | [https://github.com/zengpi/pi-cloud.git](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fzengpi%2Fpi-cloud.git) |
| 前端  | https://gitee.com/linjiabin100/pi-cloud-web.git | https://github.com/zengpi/pi-cloud-web.git                   |

#### 分支说明

**master**：主分支。最新代码的稳定分支。

**1.0.x**：1.0 版本稳定分支。

**dev**：开发分支。此分支代码随时修改，不稳定。

#### 版本说明

pi-admin 的版本号命名方式为 主版本号.次版本号.修订号：

- 主版本号 - 版本可能包含破坏性更改，如产品方向改变，或者大规模 API 不兼容，或者架构不兼容升级。
- 次版本号 - 保持相对兼容性，包含增强功能，影响范围极小的 API 不兼容修改。
- 修订号 - 版本完全向前和向后兼容，bug 修复、新增次要功能特性等。

**注意：SNAPSHOT 版本是一种特殊的版本命名约定，用于表示软件项目的开发过程中的临时版本或快照版本。SNAPSHOT 版本用于开发和测试阶段，通常不适合用于生产环境或稳定版本的部署，可能包含未经完全验证或稳定的代码。**

### 参考文档

请阅读 pi-admin 的 [参考文档](https://gitee.com/linjiabin100/pi-admin/wikis/pages) ，它描述了开发、运行 pi-admin 的必要信息以及核心原理。

阅读 [个人博客](https://gitee.com/link?target=https%3A%2F%2Fwww.cnblogs.com%2Fzn-pi%2F) 也是一个不错的选择，它是对文档很好的一个补充，阅读它会对项目有更深的理解。

### 软件架构

![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230611152901.jpg)

### 项目模块

```
- pi-admin
   - pi-boot                      项目启动入口
   - pi-common                    公共模块
      - pi-common-core            公共核心模块
      - pi-common-mybatis         mybatis 配置
      - pi-common-serialization   序列化配置
   - pi-core                      系统核心模块
      - pi-log                    日志模块
      - pi-security               安全模块
      - pi-system                 系统模块
   - pi-workflow			      工作流
```

### 功能模块

```
- 系统管理
   - 用户管理                       维护平台及租户用户
   - 菜单管理                       维护系统菜单。注意：只有平台用户才有修改权限
   - 角色管理                       维护系统角色，为角色分配菜单
   - 部门管理                       维护系统组织架构（公司、部门、组织）、数据权限等
   - 操作日志                       查看系统操作日志
   - 接口文档                       系统 API 接口文档
- 流程
   - 流程管理
      - 流程分类                    管理流程分类
      - 表单配置                    维护流程节点表单，用于收集流程数据
      - 流程建模                    bpmn 设计器，在线设计流程模型
      - 流程部署                    对流程模型进行部署
   - 流程中心
      - 新建流程                    根据流程定义创建流程实例
      - 我的流程                    查看登录用户的流程实例
      - 代办任务                    查看登录用户代办的任务
      - 抄送我的                    查看抄送给登录用户的流程
      - 已办任务                    查看登录用户已办的历史任务
- 租户
   - 企业管理                       管理企业信息，用户根据企业信息新增租户，一个企业对应一个租户。
   - 套餐管理                       维护租户所拥有的的菜单。
   - 租户管理                       维护租户信息，设置租户套餐，用户数量等。
```

## 快速开始

### 系统要求

在开始之前，您需要确保您的计算机上安装了必要的环境。

pi-admin 需要 Java 8+，同时支持 Maven 3.5 及以上版本。实际上，pi-admin 是在 Jdk 1.8.0_161下开发的。

此外，要保证 pi-admin 的正常运行，还需要在您的计算机中至少存在：MySQL、Redis。下表是以上环境版本清单：

|                                                              | 版本      |
| ------------------------------------------------------------ | --------- |
| * [Jdk](https://gitee.com/link?target=https%3A%2F%2Fwww.cnblogs.com%2Fzn-pi%2Fp%2F16859751.html) | 1.8.0_161 |
| * [Maven](https://gitee.com/link?target=https%3A%2F%2Fwww.cnblogs.com%2Fzn-pi%2Fp%2F16850827.html) | 3.8.6     |
| * [MySQL](https://gitee.com/link?target=https%3A%2F%2Fwww.cnblogs.com%2Fzn-pi%2Fp%2F16860040.html) | 8.0.31    |
| * [Redis](https://gitee.com/link?target=https%3A%2F%2Fwww.cnblogs.com%2Fzn-pi%2Fp%2F16860235.html) | 7.0.7     |
| [Docker](https://www.cnblogs.com/zn-pi/p/16861292.html)      | 23.0.5    |
| [Git](https://git-scm.com/download/linux)                    | 2.41.0    |

安装方式请点击上表对应链接或查看对应官网。

**注意：项目中 MySQL 默认用户名密码均为 `root`，Redis 的密码为 `123456`。**

#### Docker 部署开发环境

这种方式要求在你的计算机中已经安装了 Docker，如果没有，请按照系统要求中提供的方式进行安装。

1. 将项目目录 doc 中的 docker 目录上传到 Docker 服务器的根目录中，上传工具请自行选择。

2. 给 docker 目录分配权限：

   ```shell
   $ sudo chmod -R 777 /docker
   ```

3. 使用远程连接工具连接服务器并进入 /docker 目录，执行以下命令：

   ```shell
   $ sudo docker compose up -d mysql redis nginx
   ```

**注意：对于以上方式启动的 mysql，只适合在开发环境使用，生产环境请自行搭建。**

### 项目下载

```
$ git clone https://gitee.com/linjiabin100/pi-admin.git
# or
$ git clone https://github.com/zengpi/pi-admin.git
```

### 修改 hosts

在开发环境下，pi-admin 配置中的地址均设置为域名，比如：

```
spring:
  data:
    redis:
      host: pi-redis
      password: 123456
```

注意 `host` 的值 `pi-redis` 并不是 ip 地址。

如果不想修改它，您需要修改 hosts 文件。Windows 中 hosts 文件位于 `C:\Windows\System32\drivers\etc\hosts`，打开该文件，在文件末尾追加：

```
10.30.1.19 pi-redis
10.30.1.19 pi-db
10.30.1.19 pi-server
```

其中，`10.30.1.19` 为我的内网的 IP，您需要将它修改成你自己的。

为方便修改，您还可以选择使用工具 [SwitchHosts](https://gitee.com/link?target=https%3A%2F%2Fswh.app%2Fzh)，你可以很轻松地安装并使用它。

**注意：如果 hosts 文件无法写入内容，请将该文件属性的只读复选框取消勾选，具体是：右键 hosts -> 属性 -> 取消勾选“只读”复选框**

### 导入数据库

使用你喜欢的方式连接到 MySQL 数据库中，新建一个数据库，它的名称是 `pi-admin`，并将项目目录下的 `doc/sql/pi-admin_${version}.sql` 导入到新建的数据库中。

### 启动项目

项目启动入口文件：`pi-admin/pi-boot/src/main/java/me/pi/admin/AdminApplication.java`

现在使用 curl 运行服务（在一个单独的终端窗口中），通过运行以下命令（显示其输出）：

```shell
$ curl localhost:9317
Hello, Pi Admin!
```

## 预览

| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610200702.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610200729.png) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610200743.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610200755.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610200810.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610200824.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610200848.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201007.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201029.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201053.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201111.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201135.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201151.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201210.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201225.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201236.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201249.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201307.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201326.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201339.png) |
| ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201351.png) | ![](https://cdn.jsdelivr.net/gh/zengpi/image-hosting-service/pi-admin/20230610201405.png) |

