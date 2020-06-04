package dataBase;

public class BoardHandler {
	DBConnectorForWebsiteDB dbConnectorForwebsiteDB = new DBConnectorForWebsiteDB();
	
	public void connectJspToDBConnectorForLikeit(String b_idx) {
		dbConnectorForwebsiteDB.excuteUpdateLikeitOnBoardTableSql(b_idx);
	}
	
	
}
