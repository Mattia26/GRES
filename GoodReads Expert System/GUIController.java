import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.ResourceBundle;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ListView;
import javafx.scene.control.RadioButton;
import net.sf.clipsrules.jni.PrimitiveValue;

public class GUIController implements Initializable{
	
	@FXML
	private RadioButton violenzaS;
	@FXML
	private RadioButton violenzaN;
	@FXML
	private RadioButton esplicitoS;
	@FXML
	private RadioButton esplicitoN;
	@FXML
	private RadioButton lungoS;
	@FXML
	private RadioButton lungoN;
	@FXML
	private RadioButton lungoI;
	@FXML
	private RadioButton divertenteS;
	@FXML
	private RadioButton divertenteN;
	@FXML
	private RadioButton divertenteI;
	@FXML
	private RadioButton serieS;
	@FXML
	private RadioButton serieN;
	@FXML
	private RadioButton serieI;
	@FXML
	private RadioButton leggeroS;
	@FXML
	private RadioButton leggeroN;
	@FXML
	private RadioButton leggeroI;
	@FXML
	private RadioButton imprevedibileS;
	@FXML
	private RadioButton imprevedibileN;
	@FXML
	private RadioButton imprevedibileI;
	@FXML
	private RadioButton intensoS;
	@FXML
	private RadioButton intensoN;
	@FXML
	private RadioButton intensoI;
	@FXML
	private ListView lista;
	
	public void initialize(URL arg0, ResourceBundle arg1){
		
		if(DefaultChoises.getViolento().equals("sì"))
			violenzaS.setSelected(true);
		else{
			violenzaN.setSelected(true);
			violenzaN.setDisable(true);
			violenzaS.setDisable(true);
		}
		
		if(DefaultChoises.getEsplicito().equals("sì"))
			esplicitoS.setSelected(true);
		else{
			esplicitoN.setSelected(true);
			esplicitoN.setDisable(true);
			esplicitoS.setDisable(true);
		}
		
		switch(DefaultChoises.getLungo()){
		case "sì":
			lungoS.setSelected(true);
			break;
		case "no":
			lungoN.setSelected(true);
			break;
		case "indifferente":
			lungoI.setSelected(true);
		}
		
		switch(DefaultChoises.getDivertente()){
		case "sì":
			divertenteS.setSelected(true);
			break;
		case "no":
			divertenteN.setSelected(true);
			break;
		case "indifferente":
			divertenteI.setSelected(true);
			break;
		}
		
		switch(DefaultChoises.getImprevedibile()){
		case "sì":
			imprevedibileS.setSelected(true);
			break;
		case "no":
			imprevedibileN.setSelected(true);
			break;
		case "indifferente":
			imprevedibileI.setSelected(true);
			break;
		}
		
		switch(DefaultChoises.getLeggero()){
		case "sì":
			leggeroS.setSelected(true);
			break;
		case "no":
			leggeroN.setSelected(true);
			break;
		case "indifferente":
			leggeroI.setSelected(true);
			break;
		}
		
		switch(DefaultChoises.getSerie()){
		case "sì":
			serieS.setSelected(true);
			break;
		case "no":
			serieN.setSelected(true);
			break;
		case "indifferente":
			serieI.setSelected(true);
			break;
		}
	}
		
	
		
		
		
	
	
	@FXML
	public void conferma(){
		
		if((violenzaS.isSelected() || violenzaN.isSelected()) && (esplicitoS.isSelected() || esplicitoN.isSelected())
				&& (lungoS.isSelected() || lungoN.isSelected() || lungoI.isSelected())
				&& (divertenteS.isSelected() || divertenteN.isSelected() || divertenteI.isSelected())
				&& (serieS.isSelected() || serieN.isSelected() || serieI.isSelected())
				&& (leggeroS.isSelected() || leggeroN.isSelected() || leggeroI.isSelected())
				&& (imprevedibileS.isSelected() || imprevedibileN.isSelected() || imprevedibileI.isSelected())
				&& (intensoS.isSelected() || intensoN.isSelected() || intensoI.isSelected())){
			
			Main.clips.reset();
			Main.clips.assertString("(interfaccia)");
			
			if(violenzaS.isSelected())
				Main.clips.assertString("(violento si)");
			else
				Main.clips.assertString("(violento no)");
			
			if(esplicitoS.isSelected())
				Main.clips.assertString("(esplicito si)");
			else
				Main.clips.assertString("(esplicito no)");
			
			if(lungoS.isSelected())
				Main.clips.assertString("(lungo si)");
			else if(lungoN.isSelected())
				Main.clips.assertString("(lungo no)");
			else
				Main.clips.assertString("(lungo indifferente)");
			
			if(divertenteS.isSelected())
				Main.clips.assertString("(divertente si)");
			else if(divertenteN.isSelected())
				Main.clips.assertString("(divertente no)");
			else
				Main.clips.assertString("(divertente indifferente)");
			
			if(serieS.isSelected())
				Main.clips.assertString("(serie si)");
			else if(serieN.isSelected())
				Main.clips.assertString("(serie no)");
			else
				Main.clips.assertString("(serie indifferente)");
			
			if(leggeroS.isSelected())
				Main.clips.assertString("(leggero si)");
			else if(leggeroN.isSelected())
				Main.clips.assertString("(leggero no)");
			else
				Main.clips.assertString("(leggero indifferente)");
			
			if(imprevedibileS.isSelected())
				Main.clips.assertString("(imprevedibile si)");
			else if(imprevedibileN.isSelected())
				Main.clips.assertString("(imprevedibile no)");
			else 
				Main.clips.assertString("(imprevedibile indifferente)");
			
			if(intensoS.isSelected())
				Main.clips.assertString("(intenso si)");
			else if(intensoN.isSelected())
				Main.clips.assertString("(intenso no)");
			else
				Main.clips.assertString("(intenso indifferente)");
			
			Main.clips.run();
			ArrayList<String> titoli = DefaultChoises.getTitoli();
			
			lista.setItems((FXCollections.observableArrayList(titoli)));
			
			
			
		}
		
		else{
			Alert alert = new Alert(AlertType.WARNING);
			alert.setTitle("Attenzione");
			alert.setHeaderText("Compilare tutti i campi!");

			alert.showAndWait();

		}
		
	}
	

}
