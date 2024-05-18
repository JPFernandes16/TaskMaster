<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Task</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
                body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .navbar-brand {
            font-size: 1.8rem;
            font-weight: bold;
        }
        #logoutBtn {
            background-color: #ff3333;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .checkbox-group label {
            margin-right: 20px;
        }
        #currentTime {
            position: fixed;
            bottom: 20px;
            right: 20px;
            font-size: 18px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
   	<div class="container">
    <a class="navbar-brand" href="#">TASKMASTER</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="addtask.jsp">Adicionar Tarefa</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="viewtask.jsp">Visualizar Tarefa</a>
        </li>
      </ul>
    </div>
    <div class="navbar-right">
        <button id="logoutBtn" onclick="logout()">Terminar Sessão</button>
    </div>
  </div>
</nav>

<div class="container">
    <h1>Adicionar Tarefa</h1>

    <% 
        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        String dataStr = request.getParameter("data");
        String categoria = request.getParameter("categoria");

        if (nome != null && descricao != null && dataStr != null && categoria != null &&
            !nome.isEmpty() && !descricao.isEmpty() && !dataStr.isEmpty() && !categoria.isEmpty()) {

            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date;
            try {
                date = inputFormat.parse(dataStr);
            } catch (ParseException e) {
                out.println("Data inválida. Use o formato 'yyyy-MM-dd'.");
                return;
            }

            HttpSession session1 = request.getSession();
            Integer user_id = (Integer) session1.getAttribute("user_id");
            if (user_id == null) {
                out.println("Erro: user_id ausente na sessão");
                response.sendRedirect("login.jsp");
                return;
            }

            // Conexão com o banco de dados
            String URL = "jdbc:mysql://localhost:3306/servlet_register_login";
            String USERNAME = "root";
            String PASSWORD = "052167D9AD";

            try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
                String query = "INSERT INTO task (user_id, nome, descricao, data, categoria) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                    pstmt.setInt(1, user_id);
                    pstmt.setString(2, nome);
                    pstmt.setString(3, descricao);
                    pstmt.setDate(4, new java.sql.Date(date.getTime()));
                    pstmt.setString(5, categoria);
                    pstmt.executeUpdate();
                }
            } catch (SQLException e) {
                out.println("Erro ao adicionar a tarefa. Por favor, tente novamente.");
                e.printStackTrace();
                return;
            }

            response.sendRedirect("viewtask.jsp"); // Redireciona após adicionar a tarefa
        }
    %>
    <form id="addTaskForm" action="" method="post">
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" class="form-control" required><br><br>

        <label for="descricao">Descrição:</label><br>
        <textarea id="descricao" name="descricao" class="form-control" rows="4" cols="50" required></textarea><br><br>

        <label for="data">Data:</label>
        <input type="date" id="data" name="data" class="form-control" required><br><br>

        <label for="categoria">Categoria:</label>
        <input type="text" id="categoria" name="categoria" class="form-control" required><br><br>

        <input type="submit" value="Adicionar Tarefa" class="btn btn-primary" onclick="return confirm('Adicionar Tarefa?');">
    </form>
</div>

<script>
	function updateTime() {
    	var now = new Date();
    	var date = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
    	var time = now.toLocaleTimeString();
    	document.getElementById('currentTime').innerHTML = date + ' - ' + time;
	}
	window.onload = updateTime;
	setInterval(updateTime, 1000);

	document.getElementById("logoutBtn").addEventListener("click", function() {
    	if (confirm("Tem certeza que deseja terminar a sessão?")) {
        	window.location.href = "logout.jsp"; 
    	}
	});
</script>
</body>
</html>

