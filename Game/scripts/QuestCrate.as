package scripts  {
	
	import scripts.Main;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class QuestCrate extends GameObject {

		public function QuestCrate() {
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			var dropBox:Bitmap = Main.getMain().getImageLoader().getImage(xmlData[0].settings.worldgen.images.questitems.item[0].imgnum);
			addChild(dropBox);
			tag = "questCrate";
			ignore.push("bullet");
			ignore.push("questCrate");
			Main.getMain().getPlayer().addMarker(this);
		}
		override public function onCollision(other:GameObject)
		{
			super.onCollision(other);
			var otherShip = other as Ship;
			if (otherShip != null)
			{
				if (otherShip == Main.getMain().getPlayer().getShip())
				{
					Quest.crateFound();
					destroy(null);

				}
			}
		}
		override public function destroy(e:Event)
		{
			Main.getMain().getPlayer().removeMarker(this);
			super.destroy(e);

		}
	}
	
}
