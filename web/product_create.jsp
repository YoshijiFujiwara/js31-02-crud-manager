<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.ArrayList" %>
<%
    ArrayList<ArrayList<String>> categories = (ArrayList<ArrayList<String>>) request.getAttribute("categories");
    String jsCategoryNameArray = "[";
    for (ArrayList<String> data: categories) {
        jsCategoryNameArray += "{name: '" + data.get(1) + "', value: '" + data.get(0) + "'}, ";
    }
    jsCategoryNameArray += "]";

    ArrayList<ArrayList<String>> results = (ArrayList<ArrayList<String>>) request.getAttribute("results");

    // json 組み立てるか
    String jsProductArray = "[";
    for (ArrayList<String> data: results) {
        jsProductArray += "{name: '" + data.get(0) + "', categoryName: '" + data.get(1) + "', price: '" + data.get(2) + "'}, ";
    }
    jsProductArray += "]";

    // messageがあるか
    String message = (String) request.getAttribute("MESSAGE");
    String existsMessage = (message == null) ? "false" : "true";
%>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <title>Title</title>
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
                        商品を作成しました。
                    </v-alert>
                    <h1 class="font-weight-regular">商品登録</h1>
                    <form action="/login3_war_exploded/management/products/store" method="post">

                        <v-layout row wrap>
                            <v-flex xs12 sm6 md3>
                                <v-text-field
                                        v-model="productName"
                                        name="name"
                                        label="商品名"
                                ></v-text-field>
                            </v-flex>
                        </v-layout>

                        <v-layout wrap align-center>
                            <v-flex xs12 sm6 d-flex>
                                <v-select
                                        :items="<%=jsCategoryNameArray%>"
                                        item-text="name"
                                        item-value="value"
                                        v-model="selectedCategory"
                                        label="カテゴリーを選択してください"
                                        solo
                                ></v-select>
                            </v-flex>
                        </v-layout>

                        <input type="hidden" name="category_id" :value="selectedCategoryId">

                        <v-layout row wrap>
                            <v-flex xs12 sm6 md3>
                                <v-text-field
                                        v-model="productPrice"
                                        name="price"
                                        label="価格"
                                ></v-text-field>
                            </v-flex>
                        </v-layout>

                        <v-btn v-if="submitOk" type="submit" color="success">商品を追加</v-btn>
                    </form>
                </v-flex>

                <v-flex class="px-5">
                    <h1 class="font-weight-regular">現在の商品一覧</h1>
                    <v-data-table
                            :headers="headers"
                            :items="<%=jsProductArray%>"
                            class="elevation-1"
                    >
                        <template v-slot:items="props">
                            <td class="text-xs-left">{{ props.item.name }}</td>
                            <td class="text-xs-left">{{ props.item.categoryName }}</td>
                            <td class="text-xs-left">{{ props.item.price }}円</td>
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
            selectedCategory: "",
            productName: "",
            productPrice: "",
            headers: [
                { text: '商品名', value: 'calories' },
                { text: 'カテゴリー名', value: 'fat' },
                { text: '価格', value: 'carbs' },
            ],
        },
        computed: {
            selectedCategoryId: function () {
                return this.selectedCategory
            },
            submitOk: function () {
                if (this.selectedCategoryId === "" || this.productName === "" || this.productPrice === "") {
                    return false
                }
                return true
            }
        },
        created: function() {
            console.log(this.$el.getAttribute('data-categories'))
        }
    })
</script>
</body>
</html>
