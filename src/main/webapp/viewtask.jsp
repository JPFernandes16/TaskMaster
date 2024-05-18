<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visualizar Tarefas - TASKMASTER</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            position: relative;
            min-height: 100vh;
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

        .table {
            margin-top: 20px;
        }

        .btn-edit, .btn-delete {
            margin-right: 5px;
        }

        .datetime {
            position: fixed;
            bottom: 10px;
            right: 10px;
            font-size: 1rem;
            color: #6c757d;
        }

        .filter-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
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
          <a class="nav-link active" aria-current="page" href="viewtask.jsp">Visualizar Tarefas</a>
        </li>
      </ul>
    </div>
    <div class="navbar-right">
        <button id="logoutBtn" onclick="logout()">Terminar Sessão</button>
    </div>
  </div>
</nav>

<div class="container">
    <h1>Visualizar Tarefas</h1>
    <div class="filter-container">
        <form method="get" class="d-flex">
            <select name="order" class="form-select me-2">
                <option value="asc">Data Ascendente</option>
                <option value="desc">Data Descendente</option>
            </select>
            <select name="categoria" class="form-select me-2">
                <option value="">Todas as Categorias</option>
                <% 
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/servlet_register_login", "root", "052167D9AD");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT DISTINCT categoria FROM task WHERE user_id = " + request.getSession().getAttribute("user_id"));
                    while(rs.next()) {
                %>
                <option value="<%= rs.getString("categoria") %>"><%= rs.getString("categoria") %></option>
                <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </select>
            <button type="submit" class="btn btn-primary">Filtrar</button>
        </form>
    </div>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Nome da Tarefa</th>
                <th>Descrição</th>
                <th>Data</th>
                <th>Categoria</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <% 
            String order = request.getParameter("order");
            if (order == null || (!order.equals("asc") && !order.equals("desc"))) {
                order = "asc";
            }

            String categoria = request.getParameter("categoria");
            String categoriaQuery = (categoria == null || categoria.isEmpty()) ? "" : " AND categoria = '" + categoria + "'";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/servlet_register_login", "root", "052167D9AD");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM task WHERE user_id = " + request.getSession().getAttribute("user_id") + categoriaQuery + " ORDER BY data " + order);

                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy");
                while(rs.next()) {
                    String formattedDate = outputFormat.format(inputFormat.parse(rs.getString("data")));
            %>
                    <tr>
                        <td><%= rs.getString("nome") %></td>
                        <td><%= rs.getString("descricao") %></td>
                        <td><%= formattedDate %></td>
                        <td><%= rs.getString("categoria") %></td>
                        <td>
                            <a href="editTask.jsp?id=<%= rs.getInt("id") %>&nome=<%= rs.getString("nome") %>&descricao=<%= rs.getString("descricao") %>&data=<%= rs.getString("data") %>&categoria=<%= rs.getString("categoria") %>" class="btn btn-primary btn-edit">Editar</a>
                            <a href="deleteTask.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-delete" onclick="return confirm('Tem certeza que deseja excluir esta tarefa?')">Excluir</a>
                        </td>
                    </tr>
            <% 
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </tbody>
    </table>
</div>

<div class="datetime" id="datetime"></div>

<script>
    function logout() {
        if (confirm("Tem certeza que deseja terminar a sessão?")) {
            window.location.href = "logout.jsp";
        }
    }

    function updateDateTime() {
        var now = new Date();
        var date = now.toLocaleDateString('pt-PT', { day: '2-digit', month: '2-digit', year: 'numeric' });
        var time = now.toLocaleTimeString('pt-PT');
        document.getElementById('datetime').innerText = date + ' ' + time;
    }

    setInterval(updateDateTime, 1000);
    updateDateTime();
</script>
</body>
</html>
