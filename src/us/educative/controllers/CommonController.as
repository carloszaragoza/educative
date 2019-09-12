package us.educative.controllers
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;

import us.educative.VO.PeriodoVO;

import us.educative.VO.UsuarioDTO;
	import us.educative.events.CommonEvent;
	import us.educative.models.CommonModel;
	import us.educative.models.DireccionModel;
	import us.educative.models.EmpleadoModel;
	import us.educative.models.NivelEducativoModel;
import us.educative.models.PeriodoModel;
import us.educative.models.PeriodoModel;
	import us.educative.services.CommonService;
	import us.educative.services.DireccionService;
	import us.educative.services.EmpleadoService;
	import us.educative.services.NivelEducativoService;
	import us.educative.services.PeriodoService;
	
	public class CommonController extends AbstractController
	{
		private var commonService:CommonService = new CommonService();
		private var direccionSerice:DireccionService = new DireccionService();
		private var periodoService:PeriodoService = new PeriodoService();
		private var empleadoService:EmpleadoService = new EmpleadoService();
		private var nivelEducativoService:NivelEducativoService = new NivelEducativoService();
		
		[Inject]
		public var commonModel:CommonModel;
		
		[Inject]
		public var direccionModel:DireccionModel;
		
		[Inject]
		public var periodoModel:PeriodoModel;
		
		[Inject]
		public var empleadoModel:EmpleadoModel;
		
		[Inject]
		public var nivelEducativoModel:NivelEducativoModel;
		
		public function CommonController()
		{
			super();
		}
		
		[PostConstruct]
		public function init():void{
			executeServiceCall(commonService.getAllPadres(), getAllPadresResult, commonFault);
			executeServiceCall(direccionSerice.catEntidadService(), catEntidadesResult, commonFault);
			executeServiceCall(commonService.getAllPerfiles(), getAllPerfilesResult, commonFault);
			executeServiceCall(periodoService.getAll(), getAllPeriodoResult, commonFault);
			executeServiceCall(nivelEducativoService.getAll(), nivelEducativoServiceResult, commonFault);
			executeServiceCall(commonService.getPeriodo(),getPeriodoResult, commonFault);
			getProfesores();
			getChartSexo();
			getChartIngresos();
			getChartPorCobrar();
			getChartNivelesAlumnos();
			
		}



		private function getPeriodoResult(event:ResultEvent):void {
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				var periodoLocal:ArrayCollection = new ArrayCollection(event.result as Array);
				var objeto:Object = periodoLocal.getItemAt(0);
				periodoModel.cicloVigente.id_periodo = objeto.id_periodo;
				periodoModel.cicloVigente.fecha_final = objeto.fecha_final;
				periodoModel.cicloVigente.fecha_inicial = objeto.fecha_inicial;
				periodoModel.cicloVigente.nombre = objeto.nombre;
				periodoModel.cicloVigente.status = objeto.status;
				periodoModel.cicloVigente.tipo_periodo = objeto.tipo_periodo;
				trace(periodoModel.cicloVigente);
			}
		}
		
		[EventHandler(event="EmpleadoEvent.EMPLEADO_GET_PROFESORES")]
		public function getProfesores():void
		{
			executeServiceCall(empleadoService.getAllProfesors(), getAllProfesorsResult, commonFault);
		}
		
		private function nivelEducativoServiceResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				nivelEducativoModel.nivelEducativoList = new ArrayCollection(event.result as Array);
			}
		}
		private function getAllProfesorsResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				empleadoModel.profesorList = new ArrayCollection(event.result as Array);
			}
		}
		private function getAllPeriodoResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			periodoModel.periodoList = new ArrayCollection(event.result as Array);
		}
		
		private function getAllPerfilesResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				commonModel.perfilesList = new ArrayCollection(event.result as Array);
			}
			
		}
		
		private function catEntidadesResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			try{
				if(event.result.hasOwnProperty('error')){
					Alert.show(event.result.error, "Error");
				}else{
					direccionModel.acListEntidad = new ArrayCollection(event.result as Array);
				}
			} catch (e:Error)
			{
				Alert.show(e.message);
			}
		}
		
		
		
		private function getAllPadresResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else{
				commonModel.padresList = new ArrayCollection(event.result as Array);
			}
		}
		
		
		[EventHandler(event="CommonEvent.USER_TRY_LOGIN_EVENT", properties="usuario")]
		public function tryLoginClic(usuario:UsuarioDTO):void
		{
			executeServiceCall(commonService.userLogin(usuario), userLoginResult, commonFault);
			
		}
		
		private function userLoginResult(event:ResultEvent):void
		{
			if(event.result){
				var eventLogin:CommonEvent = new CommonEvent(CommonEvent.USER_LOGGED_EVENT);
				var objeto:Object = event.result;
				commonModel.id_usuario = objeto.id_usuario;
				this.dispatcher.dispatchEvent(eventLogin);
			}else
			{
				Alert.show("No se encontró tu usuario","Firma");
			}
		}
		
		private function commonFault(event:FaultEvent):void
		{
			Alert.show(event.fault.message,"Error NET");
		}
		
		[EventHandler(event="CommonEvent.DASHBOARD_GET_CHARTS")]
		public function getChartSexo():void
		{
			executeServiceCall(commonService.getAlumnosSexoGrafica(), getAlumnosSexoGraficaResult, commonFault);
		}
		
		private function getAlumnosSexoGraficaResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				commonModel.dashboardSexoAlumnosList = new ArrayCollection(event.result as Array);
			}
		}
		[EventHandler(event="CommonEvent.DASHBOARD_GET_CHARTS")]
		public function getChartNivelesAlumnos():void
		{
			executeServiceCall(commonService.getNivelAlumnos(),getNivelAlumnosResult,commonFault);
		}
		
		private function getNivelAlumnosResult(event:ResultEvent):void
		{
			// TODO Auto Generated method stub
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				commonModel.dashboardNievelesAlumnosList = new ArrayCollection(event.result as Array);
			}
		}
		[EventHandler(event="CommonEvent.DASHBOARD_GET_CHARTS")]
		public function getChartIngresos():void
		{
			executeServiceCall(commonService.getIngresos(),getIngresosResult, commonFault);
		}
		
		private function getIngresosResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				commonModel.dashboardIngresosList = new ArrayCollection(event.result as Array);
			}
		}
		[EventHandler(event="CommonEvent.DASHBOARD_GET_CHARTS")]
		public function getChartPorCobrar():void
		{
			executeServiceCall(commonService.getPorCobrar(), getPorCobrarResult, commonFault);
		}
		
		private function getPorCobrarResult(event:ResultEvent):void
		{
			if(event.result.hasOwnProperty('error')){
				Alert.show(event.result.error, "Error");
			}else
			{
				commonModel.dashboardPorCobrarList = new ArrayCollection(event.result as Array);
			}
		}
		
	}
}
