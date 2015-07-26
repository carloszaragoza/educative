package us.educative.models
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class GruposModel
	{
		public var gruposAllList:ArrayCollection;
        public var gruposList:ArrayCollection;
        public var alumnosGrupoList:ArrayCollection;
        public var alumnosNoInscritosList:ArrayCollection;
		public function GruposModel()
		{
		}
	}
}