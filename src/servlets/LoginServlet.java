package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 文字化け対策
        request.setCharacterEncoding("UTF-8");

        // htmlから受信
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String submitBtn = request.getParameter("submit-btn");

        // リダイレクトファイル
        String fileName = "/login_ng.jsp";
        String message = "";

        // 出力
        System.out.println(username);
        System.out.println(password);
        System.out.println(submitBtn);

        // try{} の外でConnection, Statementを宣言
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jv3_login?characterEncoding=utf8&useSSL=false", "root", "root");
            st = con.createStatement();

            String sql = "SELECT * FROM users WHERE username = '" + username + "';";

            // 参照系SQLを実行(これが無いとrs動かない)
            rs = st.executeQuery(sql);

            // sql出力
            System.out.println("参照するSQL: " + sql);

            // 登録かログインか削除で処理を分岐させる
            switch (submitBtn) {
                case "login":
                    System.out.println("ログイン処理");

                    if (rs.next()) {
                        System.out.println("db password");
                        System.out.println(rs.getString("password"));

                        if (password.equals(rs.getString("password"))) {
                            fileName = "/login_ok.jsp";
                            message = "ログイン成功しました";
                        } else {
                            message = "パスワードが違います";

                            // 出力
                            System.out.println(username);
                            System.out.println(message);
                        }
                    } else {
                        message = "そのユーザーはデータベースにありません";

                        // 出力
                        System.out.println(username);
                        System.out.println(message);
                    }

                    break;
                case "register":
                    System.out.println("登録処理");
                    fileName = "register_ng.jsp";

                    // そのユーザー名がない場合のみ実行
                    if (! rs.next()) {
                        String insertSql = "INSERT INTO users (username, password) VALUES ('" + username +"', '" + password + "')";
                        st.executeUpdate(insertSql);

                        fileName = "/register_ok.jsp";
                        message = "ユーザー登録しました";
                    } else {
                        message = "すでにそのユーザー名は使われています";

                        // 出力
                        System.out.println(username);
                        System.out.println(message);
                    }

                    break;
                case "update":
                    System.out.println("パスワード更新");
                    fileName = "update_ng.jsp";

                    // そのユーザー名がいる場合のみ実行
                    if (rs.next()) {
                        String updateSql = "UPDATE users SET password = '" + password + "' WHERE username = '" + username + "';";
                        st.executeUpdate(updateSql);

                        fileName = "/update_ok.jsp";
                        message = "パスワードを更新しました";
                    } else {
                        message = "そのユーザーはデータベースにありません";

                        // 出力
                        System.out.println(username);
                        System.out.println(message);
                    }

                    break;
                case "delete":
                    System.out.println("パスワード更新");
                    fileName = "delete_ng.jsp";

                    // そのユーザー名がいる場合のみ実行
                    if (rs.next()) {
                        String updateSql = "DELETE FROM users WHERE username = '" + username + "';";
                        st.executeUpdate(updateSql);

                        fileName = "/delete_ok.jsp";
                        message = "ユーザを消去しました";
                    } else {
                        message = "そのユーザーはデータベースにありません";

                        // 出力
                        System.out.println(username);
                        System.out.println(message);
                    }

                    break;
                default:
                    break;
            }

            // JSPに値を飛ばす
            request.setAttribute("MESSAGE", message);

            RequestDispatcher rd = request.getRequestDispatcher(fileName);
            rd.forward(request, response);

        } catch (ClassNotFoundException e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/ng.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/ng2.jsp");
            rd.forward(request, response);

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {

                }
            }

//            if (st != null) {
//                try {
//                    st.close();
//                } catch (SQLException e) {
//                    request.setAttribute("error", e.getMessage());
//                    RequestDispatcher rd = request.getRequestDispatcher("/ng3.jsp");
//                    rd.forward(request, response);
//                }
//            }
//
//            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
//            rd.forward(request, response);
        }



//        // ２次元配列と１次元を扱う
//        ArrayList<ArrayList<String>> tbl = new ArrayList<ArrayList<String>>();
//
//        while (rs.next()) {
//            ArrayList<String> rec = new ArrayList<String>();
//            rec.add(rs.getString("id"));
//            rec.add(rs.getString("name"));
//            rec.add(rs.getString("price"));
//            tbl.add(rec);
//        }

    }
}
