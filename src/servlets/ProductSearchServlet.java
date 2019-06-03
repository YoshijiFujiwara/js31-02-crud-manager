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

@WebServlet(name = "ProductSearchServlet")
public class ProductSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductSearchServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 文字化け対策
        request.setCharacterEncoding("UTF-8");

        String categoryName = request.getParameter("category"); // v-selectでは渡せそうにないので、hiddenタイプのinput経由で取得する
        String priceMin = request.getParameter("minPrice");
        String priceMax = request.getParameter("maxPrice");

        // try{} の外でConnection, Statementを宣言
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jv3_product_search?characterEncoding=utf8&useSSL=false", "root", "root");
            st = con.createStatement();

            // カテゴリー一覧取得SQL
            String sql = "SELECT p.name AS 商品名, c.name AS カテゴリー名, p.price AS 価格 FROM products p ";
            sql += "INNER JOIN categories c ON c.id = p.category_id ";
            sql += "WHERE c.name = '" + categoryName +"' AND p.price BETWEEN '" + priceMin +"' AND '" + priceMax + "'";

            // 参照系SQLを実行(これが無いとrs動かない)
            rs = st.executeQuery(sql);

            // sql出力
            System.out.println("参照するSQL: " + sql);

            ArrayList<ArrayList<String>> results = new ArrayList<ArrayList<String>>();
            while (rs.next()){
                ArrayList<String> record = new ArrayList<String>();
                record.add(rs.getString("商品名"));
                record.add(rs.getString("カテゴリー名"));
                record.add(rs.getString("価格"));
                results.add(record);
            }

            // jspに値を渡す
            request.setAttribute("results", results);
            RequestDispatcher rd = request.getRequestDispatcher("/result.jsp");
            rd.forward(request, response);

        } catch (ClassNotFoundException e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/ng.jsp");
            rd.forward(request, response);

        }
        catch (SQLException e) {
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

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }
}
