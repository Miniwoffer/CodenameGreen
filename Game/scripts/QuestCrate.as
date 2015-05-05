package scripts  {
	
	import scripts.Main;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	//Skriptet blir kjørt utenfra når vi aktiverer questet i Quest.as. Hovedpoenget med klassen er å skape en boks som får en hitboks (siden klassen er en utvidelse av
	// gameobject (som automatisk har hitboks)). Dette gjør at vi kan "merke" når spilleren kolliderer med boksen. Dersom spillerens skip kolliderer med boksen
	// setter vi at kassen er funnet! Vi kaller også på "marker" funksjonen som viser til hvor boksen er, samt ødelegger den når spilleren er ferdig.
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
