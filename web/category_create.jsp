<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.ArrayList" %>
<%
    ArrayList<ArrayList<String>> categories = (ArrayList<ArrayList<String>>) request.getAttribute("categories");
    String jsNameArray = "[";
    for (ArrayList<String> data: categories) {
        jsNameArray += "{name: '" + data.get(1) + "', value: '" + data.get(0) + "'}, ";
    }
    jsNameArray += "]";

    // messageがあるか
    String message = (String) request.getAttribute("MESSAGE");
    String existsMessage = (message == null) ? "false" : "true";
%>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <title>カテゴリー作成</title>
</head>
<body>
<div id="app">
    <v-app>
        <%--  ツールバー読み込み　--%>
        <%@ include file="components/management_toolbar.jsp" %>
        <v-container fluid grid-list-xl>
            <v-layout row wrap>
                <v-flex>
                    <v-alert
                        v-model="alert"
                        dismissible
                        type="success"
                    >
                        カテゴリーを作成しました。
                    </v-alert>
                    <h1 class="font-weight-regular">カテゴリー登録</h1>
                    <form action="/login3_war_exploded/management/categories/store" method="post">
                        <v-layout row wrap>
                            <v-flex xs12>
                                <v-text-field
                                    v-model="categoryName"
                                    name="name"
                                    label="カテゴリー名"
                                ></v-text-field>
                            </v-flex>
                        </v-layout>

                        <div v-if="categoryName">
                            <v-btn type="submit" color="success">カテゴリーを追加</v-btn>
                            <p v-if="existsSameName" class="red--text darken-1">同じカテゴリー名があります</p>
                        </div>
                    </form>
                </v-flex>
                <v-flex class="px-5">
                    <h1 class="font-weight-regular">現在のカテゴリー一覧</h1>
                    <v-data-table
                        :headers="headers"
                        :items="<%=jsNameArray%>"
                        class="elevation-1"
                    >
                        <template v-slot:items="props">
                            <td class="text-xs-left">{{ props.item.value }}</td>
                            <td class="text-xs-left">{{ props.item.name }}</td>
                        </template>
                    </v-data-table>
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
            alert: <%= existsMessage%>,
            headers: [
                { text: 'カテゴリーID', value: 'fat' },
                { text: 'カテゴリー名', value: 'fat' },
            ],
            dialog: false,
            categoryName: '',
            categoryArray: <%= jsNameArray%>,
        },
        computed: {
            existsSameName: function () {
                for (let i = 0; i < this.categoryArray.length; i++) {
                    if (this.categoryName == this.categoryArray[i].name) {
                        return true
                    }
                }
                return false
            }
        },
        methods: {
            handleSubmit: function () {
                this.dialog = true
            }
        },
    })
</script>
</body>
</html>
