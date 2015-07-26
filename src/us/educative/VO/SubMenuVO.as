package us.educative.VO
{
	public class SubMenuVO
	{
		private var _nombreSubMenu:String;
		private var _indice:int;
		private var _componente:String; 
		private var _privilegio:int;
		public function SubMenuVO()
		{
		}

		public function get privilegio():int
		{
			return _privilegio;
		}

		public function set privilegio(value:int):void
		{
			_privilegio = value;
		}

		public function get componente():String
		{
			return _componente;
		}

		public function set componente(value:String):void
		{
			_componente = value;
		}

		public function get indice():int
		{
			return _indice;
		}

		public function set indice(value:int):void
		{
			_indice = value;
		}

		public function get nombreSubMenu():String
		{
			return _nombreSubMenu;
		}

		public function set nombreSubMenu(value:String):void
		{
			_nombreSubMenu = value;
		}

	}
}