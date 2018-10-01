import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

public class generateinserts {
    public static void main(String[] Args) {
        generateinserts x = new generateinserts();
        String ing[] = {"Water","Hops","Apple","Pear","Cinamon","LiquidFire","Barley","Mitochondria","ToadsEyes","WitchesNose","DragonsBeard","RollerSkates"};
        String bName[]= {"TearsOfAVirgin","SaltySeaWater","GaseousVolcano","LiquidIceberg","LukeSkyWalkersGreenNippleJuice","ToiletWater"};
        String eqName[] = {"Falengie","MicroFalengie","Vat","SiphonDiphon","DistilMyShistil","LolIDK"};
        String empName[] = {"Tynan Davis","Alex Wong","Simon Hsu","Andrew Tran","Steve Jobs","Michael Jordan", "Captain America","Black Panther"};
        //ENTITIES
        x.createIngredients(ing);
        List<String> BeerID = x.createBeerTable(bName);
        List<String> EquipID = x.createEquipment(eqName);
        List<String> EmployeeID = x.createEmployee(empName);
        List<String> SalesID = x.createBrewSalesMaint(EmployeeID);
        List<String> CustID = x.createCustomer(SalesID);

        //WEAK ENTITIES
        List<String> BatchID = x.createBatch(BeerID);
        List<String> CaseID = x.createCase(BatchID);

        //RELATIONS
        x.createMaintains(EquipID, EmployeeID);
        x.createBrews(BatchID, EmployeeID, BeerID);
        x.createPurchases(CustID, CaseID, BeerID);
        x.createRecipe(BeerID,ing);
    }
    public void createIngredients(String[] ing) {
        Path file = Paths.get("ingredients.sql");
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 12; i++) {
                lines.add("INSERT INTO ingredients VALUES('"+ing[i]+"');");
            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
    }
    public List createBeerTable(String[] bName) {
        Path file = Paths.get("beer.sql");
        List<String> BeerIDs = new ArrayList<>();
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 6; i++) {
                int BeerID = (int)(Math.random()*1000000000);
                double x = Math.random()*6+6.0;
                String ABV = String.format("%.2f",x);
                double y = Math.random()*120;
                String IBU = String.format("%.2f",y);
                double z = Math.random()*3+3;
                String PricePerLitre = String.format("%.2f",z);
                lines.add("INSERT INTO beer VALUES ("+BeerID+",'" + bName[i] + "',"+ABV+","+IBU+","+PricePerLitre+");");
                BeerIDs.add(""+ BeerID);
            }
            Files.write(file,lines, Charset.forName("UTF-8"));

        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        return BeerIDs;
    }
    public List createEquipment(String[] eName) {
        Path file = Paths.get("equipment.sql");
        List<String> EquipIDs = new ArrayList<>();
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 6; i++) {
                int EquipmentID = (int)(Math.random()*1000000000);
                String date = (int)(Math.random()*1000 + 1000) + "-" + (int)(Math.random()*11 + 1) + "-" + (int)(Math.random()*27+1);
                lines.add("INSERT INTO equipment VALUES("+EquipmentID+",'"+eName[i]+"','"+date+"');");
                EquipIDs.add(""+EquipmentID);
            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        return EquipIDs;
    }
    public List createEmployee(String[] eName) {
        Path file = Paths.get("employee.sql");
        List<String> EmployeeIDs = new ArrayList<>();
        String[] address = {"3501 rue University, Quebec, Canada", "42 Wallaby Way, Sydney, Australia","Wayne Manor, Gotham City, USA", "2001 Dark Side, Moon","Cantina, Mos Eisley, Tatooine, Galaxy Far Far Away", "Cell 2187, Detention Block AA-23, Death Star, Galaxy Far Far Away"};
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 6; i++) {
                int EmployeeID = (int)(Math.random()*1000000000);
                int salary = (int)(Math.random()*1000000);
                String startdate = (int)(Math.random()*1000 + 1000) + "-" + (int)(Math.random()*11 + 1) + "-" + (int)(Math.random()*27 + 1);
                lines.add("INSERT INTO employee VALUES("+EmployeeID+",'"+eName[i]+"',"+salary+",'"+address[i]+"','"+startdate+"');");
                EmployeeIDs.add(""+EmployeeID);
            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        return EmployeeIDs;
    }
    public void createRecipe(List BeerID, String[] ing) {
        Path file = Paths.get("recipe.sql");
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 100; i++) {
                int RandBeer = (int)(Math.random()*6);
                lines.add("INSERT INTO recipe VALUES("+BeerID.get(RandBeer)+",'"+ing[(int)(Math.random()*12)]+"');");
            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
    }
    public List createBrewSalesMaint(List EmployeeID) {
        Path file = Paths.get("brewer.sql");
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 2; i++) {
                lines.add("INSERT INTO brewer VALUES("+EmployeeID.get(i)+");");
            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        Path file2 = Paths.get("sales.sql");
        List<String> SalesIDs = new ArrayList<>();
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 2; i < 4; i++) {
                lines.add("INSERT INTO sales VALUES("+EmployeeID.get(i)+");");
                SalesIDs.add(""+EmployeeID.get(i));
            }
            Files.write(file2,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        Path file3 = Paths.get("maintenance.sql");
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 4; i < 6; i++) {
                lines.add("INSERT INTO maintenance VALUES("+EmployeeID.get(i)+");");
            }
            Files.write(file3,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        return SalesIDs;
    }
    public List createCustomer(List SalesID) {
        Path file = Paths.get("customer.sql");
        List<String> CustomerIDs = new ArrayList<>();
        String cName[] = {"Mr. Poopy Butthole","Bev","Jerry","Rick","Morty","Summer"};
        String eAddr[] = {"420blazeit@hotmail.com","wakaka@gmail.com","youdontknowme@yahoo.com","bigcowstrongchicken@gmail.com","dropitlikeitscold@hotmail.com","zipzap@yahoo.com"};
        String dAddr[] = {"1 Ave WALAO","6 Hong Gan Plz","Area 51","The Jupiter System","Hoth Rebel Base","221b Baker Street"};
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 6; i++) {
                int CustomerID = (int)(Math.random()*1000000000);
                lines.add("INSERT INTO customer VALUES("+CustomerID+",'"+cName[i]+"','"+eAddr[i]+"','"+dAddr[i]+"',"+SalesID.get((int)Math.random()*SalesID.size())+");");
                CustomerIDs.add(""+CustomerID);
            }
            Files.write(file,lines, Charset.forName("UTF-8"));

        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        return CustomerIDs;
    }

    public void createMaintains(List<String> equipmentid, List<String> employeeid ) {
        Path file = Paths.get("maintains.sql");
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 20; i++){

                String date = (int)(Math.random()*1000 + 1000) + "-" + (int)(Math.random()*11 + 1) + "-" + (int)(Math.random()*27 + 1);
                lines.add("INSERT INTO maintains VALUES('"+ date + "'," + equipmentid.get((int)(Math.random()*equipmentid.size())) +"," + employeeid.get((int)(Math.random()*employeeid.size())) +");");

            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        }   catch (IOException e) {
            System.out.println("Error Writing to file");

        }
    }

    public void createBrews(List<String> batchnum, List<String> employeeid, List<String> beerid) {
        Path file = Paths.get("brews.sql");
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 20; i++){
                int randomYear = (int)(Math.random()*1000 + 1000);
                String startDate = (int)randomYear + "-" + (int)(Math.random()*11 + 1) + "-" + (int)(Math.random()*27 + 1);
                String endDate = ((int)randomYear+1) + "-" + (int)(Math.random()*11 + 1) + "-" + (int)(Math.random()*27 + 1);
                lines.add("INSERT INTO brews VALUES('"+ startDate + "','" + endDate + "'," + employeeid.get((int)(Math.random()*employeeid.size())) +"," + batchnum.get((int)(Math.random()*batchnum.size())) + "," + beerid.get((int)(Math.random()*beerid.size())) +");");

            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        }   catch (IOException e) {
            System.out.println("Error Writing to file");

        }
    }

    public void createPurchases(List<String> customerid, List<String> caseid, List<String> beerid) {
        Path file = Paths.get("purchase.sql");
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 20; i++){
                lines.add("INSERT INTO purchase VALUES("+ customerid.get((int)(Math.random()*customerid.size())) +"," + caseid.get(i) + "," + beerid.get((int)(Math.random()*beerid.size())) +");");

            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        }   catch (IOException e) {
            System.out.println("Error Writing to file");

        }
    }
    public List createBatch(List BeerID) {
        Path file = Paths.get("batch.sql");
        List<String> BatchNums = new ArrayList<>();
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 100; i++) {
                int batchNum = (int)(Math.random()*1000000000);
                int batchSize = (int)(Math.random()*1000);
                String datemade = (int)(Math.random()*1000 + 1000) + "-" + (int)(Math.random()*11 + 1) + "-" + (int)(Math.random()*27 + 1);
                lines.add("INSERT INTO batch VALUES("+batchNum+","+batchSize+",'"+datemade+"',"+BeerID.get((int)Math.random()*BeerID.size())+");");
                BatchNums.add(""+batchNum);
            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        return BatchNums;
    }

    public List createCase(List BatchNums) {
        Path file = Paths.get("case.sql");
        List<String> CaseIDs = new ArrayList<>();
        int[] caseSizes = {6, 12, 24, 36, 48, 60};
        try {
            List<String> lines = new ArrayList<>();
            for (int i = 0; i < 100; i++) {
                int caseID = (int)(Math.random()*1000000000);
                int caseSize = caseSizes[(int)(Math.random()*5)];
                double casePrice = caseSize+0.99;
                lines.add("INSERT INTO beercase VALUES("+caseID+","+casePrice+","+caseSize+","+BatchNums.get((int)Math.random()*BatchNums.size())+");");
                CaseIDs.add(""+caseID);
            }
            Files.write(file,lines, Charset.forName("UTF-8"));
        } catch (IOException e) {
            System.out.println("Error Writing to file");
        }
        return CaseIDs;
    }
}
