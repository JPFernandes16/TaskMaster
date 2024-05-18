<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Excluir Tarefa</title>
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

        .alert {
            margin-top: 20px;
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
    <h1>Excluir Tarefa</h1>
    <% 
        int taskId = Integer.parseInt(request.getParameter("id"));
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/servlet_register_login", "root", "052167D9AD");
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM task WHERE id = ?");
            pstmt.setInt(1, taskId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) { %>
                <div class="alert alert-success" role="alert">
                    Tarefa excluída com sucesso!
                </div>
            <% } else { %>
                <div class="alert alert-danger" role="alert">
                    Falha ao excluir tarefa. Tarefa não encontrada.
                </div>
            <% }
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>

<script>
    function logout() {
        if (confirm("Tem certeza que deseja terminar a sessão?")) {
            window.location.href = "logout.jsp";
        }
    }
</script>
</body>
</html>
