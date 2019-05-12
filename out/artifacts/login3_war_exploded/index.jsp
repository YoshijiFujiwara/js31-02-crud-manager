<%--
  Created by IntelliJ IDEA.
  User: yoshiji
  Date: 19/05/12
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ログイン</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
</head>
<body>
<div id="app">
    <v-app>
        <%--  ツールバー読み込み　--%>
        <%@ include file="components/toolbar.jsp" %>
        <v-container class="text-xs-center mt-5 pt-5">
            <v-layout row="row" wrap="wrap">
                <v-flex xs12="xs12" sm6="sm6" offset-sm3="offset-sm3">
                    <h1>ログイン</h1>
                </v-flex>
            </v-layout>
            <!-- signin form-->
            <v-layout row="row" wrap="wrap">
                <v-flex xs12="xs12" sm6="sm6" offset-sm3="offset-sm3">
                    <v-card>
                        <v-container>
                            <form action="./LoginServlet" method="post">
                                <v-layout row="row">
                                    <v-flex xs12="xs12">
                                        <v-text-field name="username" v-model="username" prepend-icon="face" label="ユーザーネーム" type="text" required="required"></v-text-field>
                                    </v-flex>
                                </v-layout>
                                <v-layout row="row">
                                    <v-flex xs12="xs12">
                                        <v-text-field name="password" v-model="password" prepend-icon="extension" label="パスワード" type="password" required="required"></v-text-field>
                                    </v-flex>
                                </v-layout>
                                <v-layout row="row">
                                    <v-flex xs12="xs3">
                                        <v-btn color="accent" name="submit-btn" value="login" type="submit">ログイン<span class="custom-loader" slot="loader"><v-icon light="light">cached</v-icon></span></v-btn>
                                    </v-flex>
                                    <v-flex xs12="xs3">
                                        <v-btn color="primary" name="submit-btn" value="register" type="submit">登録<span class="custom-loader" slot="loader"><v-icon light="light">cached</v-icon></span></v-btn>
                                    </v-flex>
                                    <v-flex xs12="xs3">
                                        <v-btn color="orange darken-1" name="submit-btn" value="update" type="submit">更新<span class="custom-loader" slot="loader"><v-icon light="light">cached</v-icon></span></v-btn>
                                    </v-flex>
                                    <v-flex xs12="xs3">
                                        <v-btn color="red" name="submit-btn" value="delete" type="submit">削除<span class="custom-loader" slot="loader"><v-icon light="light">cached</v-icon></span></v-btn>
                                    </v-flex>
                                </v-layout>
                            </form>
                        </v-container>
                    </v-card>
                </v-flex>
            </v-layout>
        </v-container>
    </v-app>
</div>

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.js"></script>
<script>
    new Vue({
        el: '#app',
        data: {
            username: '',
            password: ''
        },
    })
</script>
</body>
</html>