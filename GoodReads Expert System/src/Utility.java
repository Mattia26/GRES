import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.ChoiceDialog;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonBar.ButtonData;

public class Utility {
	
	public static void messaggio(String titolo, String testo){
		Alert alert = new Alert(AlertType.INFORMATION);
		alert.setTitle(titolo);
		alert.setHeaderText(testo);

		alert.showAndWait();
		
	}
	
	public static ArrayList<String> getTitoli(){
		ArrayList<String> titoli = new ArrayList<String>();
		int numTitoli;
		
		numTitoli = Integer.parseInt(Main.clips.eval("(length (find-all-facts ((?p libro)) (neq ?p:nome nil))))").toString());
		
		for(int i=1; i<=numTitoli; i++){
		
			titoli.add(Main.clips.eval("(fact-slot-value (nth$ " + i + " (find-all-facts ((?p libro)) (neq ?p:nome nil))) nome)").toString().replace("\"", "") + " - " +
						Main.clips.eval("(fact-slot-value (nth$ " + i + " (find-all-facts ((?p libro)) (neq ?p:punteggio nil))) punteggio)").toString().replace("\"", ""));
		}
		
		return titoli;
		
	}
	
	
	public static void classificazioneUtente(){

		Alert alert = new Alert(AlertType.CONFIRMATION);
		alert.setTitle("GoodReads Expert System");
		alert.setHeaderText("Quante ore leggi mediamente a settimana?");

		ButtonType buttonTypeOne = new ButtonType("0-1");
		ButtonType buttonTypeTwo = new ButtonType("1-10");
		ButtonType buttonTypeThree = new ButtonType("10+");
		ButtonType buttonTypeCancel = new ButtonType("Cancel", ButtonData.CANCEL_CLOSE);

		alert.getButtonTypes().setAll(buttonTypeOne, buttonTypeTwo, buttonTypeThree, buttonTypeCancel);

		Optional<ButtonType> result = alert.showAndWait();
		if (result.get() == buttonTypeOne){
		   DefaultChoises.setLungo("no");
		} else if (result.get() == buttonTypeTwo) {
		  DefaultChoises.setLungo("indifferente");
		} else if (result.get() == buttonTypeThree) {
		  DefaultChoises.setLungo("indifferente");
		  
		  List<String> choices = new ArrayList<>();
		  choices.add("J.K. Rowling");
		  choices.add("J.R.R. Tolkien");
		  choices.add("Charles Dickens");
		  choices.add("Arthur C. Doyle");
		  choices.add("Isaac Asimov");
		  choices.add("George Orwell");
		  choices.add("Ken Follett");
		  choices.add("Stephen King");
		  

		  ChoiceDialog<String> dialog = new ChoiceDialog<>("Nessuno di questi", choices);
		  dialog.setTitle("GoodReads Expert System");
		  dialog.setHeaderText("Scegli l'autore che più rispecchia i tuoi gusti");

		  // Traditional way to get the response value.
		  Optional<String> result2 = dialog.showAndWait();
		  if(result2.isPresent()){
		  switch(result2.get()){
		  case "J.K. Rowling":
			  DefaultChoises.setEsplicito("no");
		      DefaultChoises.setViolento("no");
		      DefaultChoises.setImprevedibile("sì");
		      DefaultChoises.setLeggero("sì");
		      break;
		  case "J.R.R. Tolkien":
			  DefaultChoises.setLungo("sì");
			  DefaultChoises.setDivertente("no");
			  DefaultChoises.setEsplicito("no");
			  DefaultChoises.setLeggero("no");
			  break;
		  case "Charles Dickens":
			  DefaultChoises.setLungo("sì");
			  DefaultChoises.setDivertente("no");
			  DefaultChoises.setEsplicito("sì");
			  DefaultChoises.setLeggero("no");
			  break;
		  case "Arthur C. Doyle":
			  DefaultChoises.setDivertente("sì");
			  DefaultChoises.setLungo("no");
			  DefaultChoises.setImprevedibile("sì");
			  DefaultChoises.setLeggero("sì");
			  break;
		  case "Isaac Asimov":
			  DefaultChoises.setLungo("no");
			  DefaultChoises.setSerie("sì");
			  DefaultChoises.setImprevedibile("sì");
			  DefaultChoises.setLeggero("sì");
			  break;
		  case "George Orwell":
			  DefaultChoises.setLungo("no");
			  DefaultChoises.setDivertente("no");
			  DefaultChoises.setLeggero("no");
			  DefaultChoises.setSerie("no");
			  break;
		  case "Ken Follett":
			  DefaultChoises.setLungo("sì");
			  DefaultChoises.setEsplicito("sì");
			  DefaultChoises.setViolento("sì");
			  DefaultChoises.setSerie("sì");
			  break;
		  case "Stephen King":
			  DefaultChoises.setViolento("sì");
			  DefaultChoises.setEsplicito("sì");
			  DefaultChoises.setLeggero("sì");
			  DefaultChoises.setSerie("sì");
			  
			  
		  }
		  System.out.println(DefaultChoises.print());
		  }
		 

		
		  
		} else {
		    System.exit(0);
		}

		
		Alert alert1 = new Alert(AlertType.CONFIRMATION);
		alert1.setTitle("GoodReads Expert System");
		alert1.setHeaderText("Quanti anni hai?");

		ButtonType buttonType1 = new ButtonType("14-");
		ButtonType buttonType2 = new ButtonType("14-18");
		ButtonType buttonType3 = new ButtonType("18+");
		ButtonType buttonTypeC = new ButtonType("Cancel", ButtonData.CANCEL_CLOSE);

		alert1.getButtonTypes().setAll(buttonType1, buttonType2, buttonType3, buttonTypeC);

		Optional<ButtonType> result1 = alert1.showAndWait();
		if (result1.get() == buttonType1){
		   DefaultChoises.setEsplicito("no");
		   DefaultChoises.setViolento("no");
		} else if (result1.get() == buttonType2) {
		  DefaultChoises.setEsplicito("no");
		  DefaultChoises.setViolento("sì");
		} else if (result1.get() == buttonType3) {
		  DefaultChoises.setEsplicito("sì");
		  DefaultChoises.setViolento("sì");
		  
		 }
		else{
			System.exit(0);
		}
		
	}
}
