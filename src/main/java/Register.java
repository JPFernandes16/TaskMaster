

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class Register
 */
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Recuperar os parâmetros do formulário
	    String nome = request.getParameter("nome");
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");

	    // Verificação de campos vazios
	    if (nome.isEmpty() || email.isEmpty() || password.isEmpty()) {
	        request.setAttribute("status", "emptyFields");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
	        dispatcher.forward(request, response);
	        return; // Encerrar a execução do método se houver campos vazios
	    }

	    // Verificação de e-mail único
	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;
	    try {
	        // Estabelecer a conexão com o banco de dados
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servlet_register_login", "root", "052167D9AD");

	        // Verificar se o e-mail já está registrado
	        pst = con.prepareStatement("SELECT * FROM user WHERE email = ?");
	        pst.setString(1, email);
	        rs = pst.executeQuery();
	        if (rs.next()) {
	            // E-mail já está em uso
	            request.setAttribute("status", "emailExists");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
	            dispatcher.forward(request, response);
	            return; // Encerrar a execução do método se o e-mail já estiver em uso
	        }

	        // Se o e-mail for único, prosseguir com a inserção no banco de dados
	        pst = con.prepareStatement("INSERT INTO user (nome, email, password) VALUES (?, ?, ?)");
	        pst.setString(1, nome);
	        pst.setString(2, email);
	        pst.setString(3, password);
	        int rowCount = pst.executeUpdate();

	        // Encaminhar para a página de registro com o status de sucesso ou falha
	        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
	        if (rowCount > 0) {
	            request.setAttribute("status", "success");
	        } else {
	            request.setAttribute("status", "failed");
	        }
	        dispatcher.forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // Fechar conexão com o banco de dados
	        try {
	            if (rs != null) rs.close();
	            if (pst != null) pst.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}


}
