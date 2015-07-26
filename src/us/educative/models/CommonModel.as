package us.educative.models
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class CommonModel
	{
		
		public var padresList:ArrayCollection;
		
		public var id_usuario:int=0;
		
		public var perfilesList:ArrayCollection;
		
		public var estudiosList:ArrayCollection = new ArrayCollection([{label:"Sin estudios", id_estudio:1},
			{label:"Primaria", id_estudio:2},
			{label:"Secundaria", id_estudio:3},
			{label:"Preparatoria", id_estudio:4},
			{label:"Universidad", id_estudio:5},
			{label:"Maestria", id_estudio:6},
			{label:"Doctorado", id_estudio:7}]);
		
		public var periodosList:ArrayCollection = new ArrayCollection([{label:"Anual", id:1},
			{label:"Semestral", id:2},
			{label:"Bimestral", id:3},
			{label:"Tetramestral", id:4},
			{label:"Trimestral", id:5}]);
		
		public var dashboardSexoAlumnosList:ArrayCollection;
		
		
		public var menuControlEscolarAdmin:ArrayCollection = new ArrayCollection([
			{name:"Alumnos", data:"alumnosContainer"},
			{name:"Padres", data:"padresContainer"},
			{name:"Periodos", data:"periodosContainer"},
			{name:"Grupos", data:"gruposContainer"}]);
		
		public var menuAdministracionFinanzasAdmin:ArrayCollection = new ArrayCollection([
			{name:"Empleados", data:"empleadosContainer"},
			{name:"Servicios y productos", data:"pagosContainer"},
			{name:"Ingresos", data:"ingresosContainer"},
			{name:"Plan de Pagos", data:"planDePagosContainer"}]);
		
		public var menuReportesAdmin:ArrayCollection = new ArrayCollection([
			{name:"Deudores y pagos por mes", data:"deudoresPorMesContainer"}]);
		
		
		public var menuDashboardAdmin:ArrayCollection = new ArrayCollection([
			{name:"Tablero", data:"tableroContainer"}]);
		
		
		public var mesesUtil:ArrayCollection = new ArrayCollection([
			{name:"Enero", data:"1"},
			{name:"Febrero", data:"2"},
			{name:"Marzo", data:"3"},
			{name:"Abril", data:"4"},
			{name:"Mayo", data:"5"},
			{name:"Junio", data:"6"},
			{name:"Julio", data:"7"},
			{name:"Agosto", data:"8"},
			{name:"Septiembre", data:"9"},
			{name:"Octubre", data:"10"},
			{name:"Noviembre", data:"11"},
			{name:"Diciembre", data:"12"}]);
		
		public var dashboardNievelesAlumnosList:ArrayCollection;
		public var dashboardIngresosList:ArrayCollection;
		public var dashboardPorCobrarList:ArrayCollection;
		
		
		
		
		
		public function CommonModel()
		{
			//listMenuAdmin.source=menuAdminXML.item.(@id=='dashboard').label as XMLList;
			
		}
		
	}
}