package us.educative.VO
{
	public class MenuVO
	{
		private var _nombreMenu:String;
		private var _indice:int;
		private var _privilegio:int;
		private var _subMenu:SubMenuVO;
		public function MenuVO()
		{
		}

		public function get subMenu():SubMenuVO
		{
			return _subMenu;
		}

		public function set subMenu(value:SubMenuVO):void
		{
			_subMenu = value;
		}

		public function get privilegio():int
		{
			return _privilegio;
		}

		public function set privilegio(value:int):void
		{
			_privilegio = value;
		}

		public function get indice():int
		{
			return _indice;
		}

		public function set indice(value:int):void
		{
			_indice = value;
		}

		public function get nombreMenu():String
		{
			return _nombreMenu;
		}

		public function set nombreMenu(value:String):void
		{
			_nombreMenu = value;
		}

	}
}