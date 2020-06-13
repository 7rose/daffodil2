# daffodil
---
总体说明:
1. graphql的调用地址是统一的,即`/graphql`
2. grahpql获取不同的内容,需要在前端执行不行的查询语句(不是sql,是graphql格式)
3. 后端会直接暴露所有字段除了密码之类的保留字段,但前端用到什么就取什么,不取的字段不会返回.
4. 流程示例:
    * 后端模型(所有暴露的字段,文件位于lilac项目/graphql下)
    ```
type User {
    id: ID!
    ids: Json! # 身份登录的信息, ids原因可能是有手机号,设备号,其他第三方等
    info: Json # 个人信息
    conf: Json # 配置
    locked: Boolean! # 账号锁
    show: Boolean! # 显示
    created_by: ID # 由谁建立
    created_at: DateTime!
    updated_at: DateTime!
    orgs: [Org!]! # 用户所有属的组织, 注意一个用户可以会属于多个组织
    roles: [Role!]! # 用户角色,同上,角色和组织是对应的
}
    ```
    后端暴露方法
    ```
type Query {
    users: [User!]! @all # 用户列表, 返回类型为上面的User数组(外面带[],没有即为空),字段任意取
    user(id: ID @eq): User @find # 按ID查询单个用户,返回用户类型(非数组,外面没有[])
}
    ```

    * 前端
    1. 配置连接(即设置统一的接口指向: https://wechat.mooibay.com/graphql)
    2. 查看lilac项目/graphl下面的文件, 直接可以看到所有暴露的字段
        ```
        schema.graphql # 包含: 所有查询方法, 变异(造成后端数据变更的)操作方法; 自定义和外部数据类型,如json
        user.graphql # 包含 "user" 所有暴露的字段, 以及其他数据库关系(调用其他模型)
        ```
    3. 具体的使用
        * 编写查询/变异
        ```
        {
            users{
                info
                orgs{
                    id
                }
            }
        }
        ```
        上述表示执行查询方法 users (对应后端方法), 获取info(用户信息), 和用户所属的组织id; 如果发现前端还需要用户创建时间和组织名称等,则:
        ```
        {
            users{
                info
                created_at
                orgs{
                    id
                    info
                }
            }
        }
        ```
        * 将查询/变异的结果写入前端状态管理(大部分情况不需要)
        * 用前端状态管理插件包裹 <widgit>
        * 显示
        