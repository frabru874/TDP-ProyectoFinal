<%@page import="java.io.InputStream"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@ page import="models.ColeccionPartidos" %>
<%@ page import="models.Partido" %>
<%@ page import="models.Jugador" %>
<%@ page import="models.Equipo" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<title> Proyecto Final Bunner - Vercelli</title>
		<link rel="stylesheet" href="CSS/styles.css?1.1.0">
		<link rel="icon" type="image/png" href="CSS/mifavicon.png" />
	</head>
	<body>
		<div id="contenedor">
			<header>
				<s:a action="index" cssClass="titulo">TDP Proyecto Final 2017</s:a>
			</header>
			<nav>
				<s:a action="index" cssClass="itemNav"> Inicio </s:a>
				<s:a action="jugadores" cssClass="itemNav"> Jugadores </s:a>
				<s:a action="equipos" cssClass="itemNav"> Equipos </s:a>
			</nav>
			<div id="separadorNavSec"></div>
			<div id="contenedor2">
				<section>
					<div id="titPartidosDisponibles">Partidos Disponibles</div>
					<% 
					response.setContentType("text/html");
					ColeccionPartidos partidos=new ColeccionPartidos();
						for(Partido partido : partidos.getPartidos())
						{
					%>
						<div id="partidosDisponibles">
							<table id="tablaPartidosDisponibles">
								<tr><td>Lugar: </td><td><%out.println(partido.getLugar()); %></td></tr>
								<tr><td>Fecha: </td><td><%out.println(partido.getFecha()); %></td></tr>
								<tr><td>Hora: </td><td><%out.println(partido.getHora()); %></td></tr>
								<tr><td>Jugadores: </td><td><%out.println(partido.getCantidadJugadores()); %></td></tr>
								<tr><td>Inscriptos: </td><td><%out.println(partido.getCantidadInscriptos()); %></td></tr>
								<tr><td>Precio: </td><td><%out.println(partido.getPrecio()); %></td></tr>
							</table>
							
							<s:if test='%{#session.user != null}'>
								<s:form action="eliminarPartido">
									<s:set var="ID_partido1"><%out.println(partido.getID_partido()); %></s:set>
									<s:hidden name="ID_partido_seleccionado" value="%{#ID_partido1}"/>
									<div class="centrar"><s:submit value="Eliminar Partido" cssClass="btnEliminar"/></div>
								</s:form>
							</s:if>
							<div id="titInscriptos">Inscriptos:</div>
							
							<table id="tablaPartidosDisponibles">
							<% 
								for(Equipo equipo : partido.getEquipos())
								{
							%>
								<tr>
								<td>Equipo: <%out.println(equipo.getNombre()); %></td>
								<td>Jugadores: <%out.println(equipo.getCantidadJugadores()); %></td>
								<td>Inscriptos: <%out.println(equipo.getCantidadInscriptos()); %></td>
								<td>
								<s:set var="cantidadInscriptos"><%out.println(equipo.getCantidadInscriptos()); %></s:set>
								<s:set var="cantidadJugadores"><%out.println(equipo.getCantidadJugadores()); %></s:set>
								<s:if test="%{#cantidadInscriptos == #cantidadJugadores}">
									Equipo Completo
								</s:if>
								<s:else>
									<s:form action="inscripcion">
										<s:set var="ID_partido0"><%out.println(partido.getID_partido()); %></s:set>
										<s:set var="equipoSel"><%out.println(equipo.getNombre()); %></s:set>
										<s:hidden name="ID_seleccionado" value="%{#ID_partido0}"/>
										<s:hidden name="equipo_seleccionado" value="%{#equipoSel}"/>
										<div class="centrar"><s:submit cssClass="bntInscribirse" value="Inscribirse" /></div>
									</s:form>
								</s:else>
								</td>
								</tr>
							<%
									for(Jugador jugador : equipo.getJugadores())
									{
							%>
								<tr>
								<td><%out.println(jugador.getNombre()); %></td>
								<td><%out.println(jugador.getApellido()); %></td>
								<td><%out.println(jugador.getDNI()); %></td>
									
									<s:if test='%{#session.user != null}'>
										<s:form action="eliminarJugador">
											<s:set var="DNI"><%out.println(jugador.getDNI()); %></s:set>
											<s:set var="ID_partido2"><%out.println(partido.getID_partido()); %></s:set>
											<s:set var="equipoSeleccionado"><%out.println(equipo.getNombre()); %></s:set>
											<s:hidden name="DNI_seleccionado" value="%{#DNI}"/>
											<s:hidden name="ID_partido_seleccionado" value="%{#ID_partido2}"/>
											<s:hidden name="equipo_seleccionado" value="%{#equipoSeleccionado}"/>
											<td><s:submit value="Eliminar Jugador" cssClass="btnEliminar"/></td>
										</s:form>
									</s:if>
								
								</tr>
							<%
									} 
								}
							%>
							</table>
						</div>
					<%
						} 
					%>
					
				</section>
				<aside>
					<s:if test='%{#session.user != null}'>
						<div id="titLoguin">Bienvenido <s:property value="%{#session['user']}"/></div>
						<s:fielderror />
						<s:form action="LogOut" method="post">
							<s:hidden name="userName" value="admin"/>
							<s:hidden name="password" value="admin"/>
							<div class="centrar"><s:submit  cssClass="btnIngresar" value="Salir"/></div>
						</s:form>
						<div class="centrar"><s:a action="agregarPartido" cssClass="btnAgregarPartido">Agregar Partido</s:a></div>
					</s:if>
					<s:else>
						<s:form action="Login" method="post">
							<div id="titLoguin">Logueo</div>
							<s:fielderror fieldName="userName" />
							<s:fielderror fieldName="password" />
							<div id="labelUser">Usuario: </div><s:textfield name="userName" cssClass="inputUser" value=""/>
							<div id="labelPass">Password: </div><s:password name="password" cssClass="inputPass" value=""/>
							
							<div class="centrar"><s:submit  cssClass="btnIngresar" value="Ingresar"/></div>
						</s:form>
					</s:else>
					<s:fielderror fieldName="nombre" />
					<s:fielderror fieldName="apellido" />
					<s:fielderror fieldName="dni" />
				</aside>
				<div id="separadorNavSec" style="float:left"></div>
			</div>
			
			<footer>Copyright &copy; 2017 - TDP 2017 - Proyecto Final - Brunner, Vercelli</footer>
		</div>
	</body>
</html>
