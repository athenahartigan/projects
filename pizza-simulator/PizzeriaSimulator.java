/**
 * Description: a simulator that prompts the user to order from one of three pizza places. As the game gets played
 * the user is able to write reviews for each of the places, which will then be displayed as the game continues. The code
 * consists of for and while loops, conditionals, and ArrayLists to take an order, store it, then display the receipt to the
 * user when they have finished ordering.
 * @author Athena and Ashlyn
 */


import java.util.Scanner;
import java.util.ArrayList;


public class PizzeriaSimulator {
    public static void main(String[] args) {
        Scanner scnr = new Scanner(System.in);
        ArrayList<String> order = new ArrayList<String>();
        Scanner user = new Scanner(System.in);
        ArrayList<Integer> papaJohnsRating = new ArrayList<>();
        ArrayList<String> papaJohnsReviews = new ArrayList<>();
        ArrayList<Integer> dominosRating = new ArrayList<>();
        ArrayList<String> dominosReviews = new ArrayList<>();
        ArrayList<Integer> cuginoFornoRating = new ArrayList<>();
        ArrayList<String> cuginoFornoReviews = new ArrayList<>();

        char keepPlaying = 'y';
        while (keepPlaying != 'n') { //to keep playing the game or not
            System.out.println("You can order from Cugino Forno, Papa Johns, or Dominos?");
            System.out.println("Would you like to see the Menus? answer y/n"); //displays menus
            String response = scnr.next();
            System.out.println();

            if (response.equals("y")) {
            System.out.println("Cugino Fornos Menu");
            System.out.println("Pizzas");
            System.out.println("Margerita $16.00: tomato sauce, mozzarella, basil, garlic");
            System.out.println("Marinara $15.00: tomato sauce, garlic, oregano *Vegan");
            System.out.println("Livorno $18.00: sausage, tomato sauce, mozzarella basil, garlic");
            System.out.println("Americano $18.00: pepperoni, tomato sauce, mozzarella, basil, garlic");
            System.out.println("Bianca $18.00: fior di latte, ricotta, mozzarella, basil, garlic");
            System.out.println("Pomodoro $18.00: cherry tomatoes, mozzarella, asil garlic");
            System.out.println("Porziano $18.00: ham, mushroom, artichoke, mozzarella");
            System.out.println("Calabrese $18.00: salami, peppers, mozzarella");
            System.out.println("Funghi $18.00: onions, mushrooms, mozzarella, truffle oil");
            System.out.println("Napoletana $19.00: sausage, red pepper, onions, mozzarella");
            System.out.println("Supremo Italiano $21.00: tomato sauce, pepperoni, sausage, ham, mozzarella, basil");

            System.out.println();
            System.out.println("Papa John's Menu");
            System.out.println("Create your own pizza (up to 4 toppings)");
            System.out.println("Crust: original, epic stuffed, thin, gluten-free");
            System.out.println("Size: small $11.00, medium $13.00, large $15.00, x-large $17.00");
            System.out.println("Sauce: none, bbq, ranch, original, garlic, buffalo, alfredo");
            System.out.println("Meats: pepperoni, anchovies, canadian bacon,beef, salami, sausage, bacon,chicken, meatball, steak");
            System.out.println("Veggies: banana peppers, tomatoes, green peppers, onions, spinach, jalapeños, mushrooms, pineapple, olives");


            System.out.println();
            System.out.println("Dominos Menu");
            System.out.println("Create your own pizza (up to 4 toppings)");
            System.out.println("Crust: brooklyn style, hand-tossed");
            System.out.println("Size: small $12.00, medium $13.00, large $14.00, x-large $15.00");
            System.out.println("Sauce: none, honey bbq, ranch, marinara, garlic parmesan, alfredo");
            System.out.println("Meats: ham, pepperoni, beef, salami, sausage, bacon, chicken, steak");
            System.out.println("Veggies: banana peppers, tomatoes, red / green peppers, onions, spinach, jalapeños, mushrooms, pineapple, olives");

            }
            System.out.println();

            Utils.topRating(cuginoFornoRating, papaJohnsRating, dominosRating); //calls the method topRating to get the top rating

            System.out.println("Would you like to read all the ratings? answer y/n"); //displays ratings
            char yesNo = scnr.next().charAt(0);
            System.out.println();

            while (yesNo != 'n' && yesNo != 'y') {
                System.out.println("Please enter a valid character. Use y for yes and n for no");
                yesNo = scnr.next().charAt(0);
                System.out.println();
            }

            if (yesNo == 'y') {
                Utils.printRatings(cuginoFornoRating, papaJohnsRating, dominosRating); //calls printRating method to print the ratings
                System.out.println();
            }

            if (yesNo == 'y') {
                System.out.println("Would you like to read all the Reviews? answer y/n"); //prints reviews
                char noYes = scnr.next().charAt(0);
                System.out.println();
                while (noYes != 'n' && noYes != 'y') {
                    System.out.println("Please enter a valid character. Use y for yes and n for no");
                    noYes = scnr.next().charAt(0);
                    System.out.println();
                }
                if (noYes == 'y') {
                    Utils.printReviews(cuginoFornoRating, papaJohnsRating, dominosRating, cuginoFornoReviews, papaJohnsReviews, dominosReviews); //calls printReviews methods to print reviews
                }
            }

            System.out.println();
            System.out.println("Now choose which place you want to order from."); //user chooses pizza placce
            String choice = user.nextLine();
            System.out.println();
        while (!choice.equals("Cugino Forno") && !choice.equals("Papa Johns") && !choice.equals("Dominos")){
            System.out.println("Please enter a valid pizza place");
            choice = user.nextLine();
            System.out.println();
        }

        if (choice.equals("Cugino Forno")) {
            System.out.println("Cugino Fornos Menu");
            System.out.println("Pizzas");
            System.out.println("Margerita $16.00: tomato sauce, mozzarella, basil, garlic");
            System.out.println("Marinara $15.00: tomato sauce, garlic, oregano *Vegan");
            System.out.println("Livorno $18.00: sausage, tomato sauce, mozzarella basil, garlic");
            System.out.println("Americano $18.0095: pepperoni, tomato sauce, mozzarella, basil, garlic");
            System.out.println("Bianca $18.00: fior di latte, ricotta, mozzarella, basil, garlic");
            System.out.println("Pomodoro $18.00: cherry tomatoes, mozzarella, asil garlic");
            System.out.println("Porziano $18.00: ham, mushroom, artichoke, mozzarella");
            System.out.println("Calabrese $18.00: salami, peppers, mozzarella");
            System.out.println("Funghi $18.00: onions, mushrooms, mozzarella, truffle oil");
            System.out.println("Napoletana $19.00: sausage, red pepper, onions, mozzarella");
            System.out.println("Supremo Italiano $21.00: tomato sauce, pepperoni, sausage, ham, mozzarella, basil");

            System.out.println("Now it's time to order! When you're done with your order input: Done");
            String userOrder = "";
            int price = 0;
            order.clear();
            while (!userOrder.equals("Done")) { //takes users order
                System.out.println("Enter your pizza order.");
                userOrder = scnr.next();
                while (!userOrder.equals("Margerita") && !userOrder.equals("Marinara") && !userOrder.equals("Livorno") && !userOrder.equals("Americano") && !userOrder.equals("Bianca") && !userOrder.equals("Pomodoro") && !userOrder.equals("Porziano") && !userOrder.equals("Calabrese") && !userOrder.equals("Funghi") && !userOrder.equals("Napoletana") && !userOrder.equals("Supremo Italiano") && !userOrder.equals("Done")){
                    System.out.println("Please enter a valid pizza");
                    userOrder = scnr.next();
                }
                if(!userOrder.equals("Done")) {
                    order.add(userOrder);
                }
                if(userOrder.equals("Supremo Italiano")){
                    price = price + 21;
                }
                else if(userOrder.equals("Napoletana")){
                    price = price + 19;
                }
                else if(userOrder.equals("Marinara")){
                    price = price + 16;
                }
                else if(userOrder.equals("Margerita")){
                    price = price + 15;
                }
                else{
                    price = price + 18;
                }

            }
            price = price - 18;
            System.out.println("Here is your receipt:"); //shows receipt
            for(int i = 0; i < order.size(); i++){
                System.out.println(order.get(i));
            }
            System.out.println("Your total is $" + price + ".00");
        }
        else if(choice.equals("Papa Johns")) {

            System.out.println("Papa John's Menu");
            System.out.println("Create your own pizza (up to 4 toppings)");
            System.out.println("Crust: original, epic-stuffed, thin, gluten-free");
            System.out.println("Size: small $11.00, medium $13.00, large $15.00, x-large $17.00");
            System.out.println("Sauce: none, bbq, ranch, original, garlic, buffalo, alfredo");
            System.out.println("Meats: pepperoni, anchovies, canadian bacon,beef, salami, sausage, bacon,chicken, meatball, steak");
            System.out.println("Veggies: banana peppers, tomatoes, green peppers, onions, spinach, jalapeños, mushrooms, pineapple, olives");

            System.out.println("Now it's time to order!");
            String userOrder = " ";
            int price = 0;
            int count = 1;
            order.clear();
            while (!userOrder.equals("n")) { //takes order
                    System.out.println("Enter your crust");
                    order.add("pizza " + count + ":");
                    userOrder = scnr.next();
                    order.add(userOrder);
                    System.out.println("Enter your size");
                    userOrder = scnr.next();
                    while (!userOrder.equals("small") && !userOrder.equals("medium") & !userOrder.equals("large") & !userOrder.equals("x-large")){
                        System.out.println("Please enter a valid size");
                        userOrder = scnr.next();
                    }
                if(userOrder.equals("small")){
                        price = price + 11;
                    }
                    else if (userOrder.equals("medium")){
                        price = price + 13;
                    }
                    else if (userOrder.equals("large")){
                        price = price + 15;
                    }
                    else if (userOrder.equals("x-large")){
                        price = price + 17;
                    }
                    order.add(userOrder);
                    System.out.println("Enter your sauce");
                    userOrder = scnr.next();
                    order.add(userOrder);
                    for (int i = 0; i < 4; i++) {
                       System.out.println("Enter your toppings, when done enter 'stop'"); //for loop to take toppings order
                        userOrder = user.nextLine();
                        if(userOrder.equals("stop")){
                            break; //if user doesn't want all four toppings
                        }
                        order.add(userOrder);
                    }
                System.out.println("Do you want to order another pizza (y/n)?"); //if user wants more than one pizza
                    count = count + 1;
                    userOrder = scnr.next();

            }
            System.out.println("Here is your receipt:");
            for(int i = 0; i < order.size(); i++){
                System.out.println(order.get(i));
            }
            System.out.println("Your total is $" + price + ".00");

        }

        else if (choice.equals("Dominos")) {

            System.out.println("Dominos Menu");
            System.out.println("Create your own pizza (up to 4 toppings)");
            System.out.println("Crust: brooklyn-style, hand-tossed");
            System.out.println("Size: small $12.00, medium $13.00, large $14.00, x-large $15.00");
            System.out.println("Sauce: none, honey-bbq, ranch, marinara, garlic-parmesan, alfredo");
            System.out.println("Meats: ham, pepperoni, beef, salami, sausage, bacon, chicken, steak");
            System.out.println("Veggies: banana peppers, tomatoes, red / green peppers, onions, spinach, jalapeños, mushrooms, pineapple, olives");

            System.out.println("Now it's time to order! When you're done with your order input: Done");
            String userOrder = " ";
            int price = 0;
            int count = 1;
            order.clear();
            while (!userOrder.equals("n")) { //takes user order
                System.out.println("Enter your crust");
                order.add("pizza " + count + ":");
                userOrder = scnr.next();
                order.add(userOrder);
                System.out.println("Enter your size");
                userOrder = scnr.next();
                order.add(userOrder);
                while (!userOrder.equals("small") && !userOrder.equals("medium") & !userOrder.equals("large") & !userOrder.equals("x-large")){
                    System.out.println("Please enter a valid size");
                    userOrder = scnr.next();
                }
                if(userOrder.equals("small")){
                        price = price + 12;
                }
                else if (userOrder.equals("medium")){
                    price = price + 13;
                }
                else if (userOrder.equals("large")){
                    price = price + 14;
                }
                else if (userOrder.equals("x-large")){
                    price = price + 15;
                }
                System.out.println("Enter your sauce");
                userOrder = scnr.next();
                order.add(userOrder);
                for (int i = 0; i < 4; i++) {
                    System.out.println("Enter your toppings, when done enter 'stop'"); //takes users toppings
                    userOrder = user.nextLine();
                    if(userOrder.equals("stop")){ // if user doesn't want all four toppings
                        break;
                    }
                    order.add(userOrder);
                }
                System.out.println("Do you want to order another pizza (y/n)?");
                count = count + 1;
                userOrder = scnr.next();

            }
            System.out.println("Here is your receipt:"); //shows receipt
            for(int i = 0; i < order.size(); i++){
                System.out.println(order.get(i));
            }
            System.out.println("Your total is $" + price + ".00");
        }
        System.out.println();

        if (choice.equals("Cugino Forno") || choice.equals("Papa Johns") || choice.equals("Dominos")) {
            System.out.println("Would you like to leave a review for " + choice + "? answer y/n");
            char leaveReview = scnr.next().charAt(0);
            while (leaveReview != 'y' && leaveReview != 'n') {
                System.out.println("Please enter a valid character. Use y for yes and n for no");
                leaveReview = scnr.next().charAt(0);
            }
            if (leaveReview == 'y') {
                System.out.println("What would you rate " + choice + " out of 5?");
                int rating = scnr.nextInt();
                while (rating > 5 || rating < 1){
                    System.out.println("Please enter a valid rating (1-5)");
                    rating = scnr.nextInt();
                }
                if (choice.equals("Cugino Forno")) {
                    cuginoFornoRating.add(rating);
                } else if (choice.equals("Papa Johns")) {
                    papaJohnsRating.add(rating);
                } else {
                    dominosRating.add(rating);
                }

                System.out.println("Why did you choose this rating?");
                Scanner rev = new Scanner(System.in);
                String review = rev.nextLine();
                if (choice.equals("Cugino Forno")) {
                    cuginoFornoReviews.add(review);
                } else if (choice.equals("Papa Johns")) {
                    papaJohnsReviews.add(review);
                } else {
                    dominosReviews.add(review);
                }
            }
            if (leaveReview == 'n') {
                System.out.println("Thank you for ordering from " + choice);
            }
        }

            System.out.println("Would you like to keep playing? answer y/n");
            keepPlaying = scnr.next().charAt(0);
            while (keepPlaying != 'n' && keepPlaying != 'y'){
                System.out.println("Please enter a valid character. Use y for yes and n for no");
                keepPlaying = scnr.next().charAt(0);
            }

        }
        System.out.println("Thank you for playing!");
    }
}
