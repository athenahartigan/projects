/**
 * @author Athena and Ashlyn
 */

import java.util.ArrayList;
public class Utils {
    /**
     * this method prints the ratings for each pizza place
     */
    public static void printRatings(ArrayList<Integer> cuginoForno,
                                    ArrayList<Integer> papaJohns,
                                    ArrayList<Integer> dominos) {
        int i;
        double ratingAvgPapa = 0;
        double ratingAvgDomino = 0;
        double ratingAvgCugino = 0;


        for (i = 0; i < cuginoForno.size(); ++i) {
            ratingAvgCugino += cuginoForno.get(i);
        }
        ratingAvgCugino = ratingAvgCugino/cuginoForno.size();

        for (i = 0; i < papaJohns.size(); ++i) {
            ratingAvgPapa += papaJohns.get(i);
        }
        ratingAvgPapa = ratingAvgPapa/papaJohns.size();


        for (i = 0; i < dominos.size(); ++i) {
            ratingAvgDomino += dominos.get(i);
        }

        ratingAvgDomino = ratingAvgDomino/dominos.size();


        if (cuginoForno.size() == 0){
            System.out.println("Cugino Forno: No ratings yet");
        }
        else {
            System.out.printf("Cugino Forno: %.2f\n", ratingAvgCugino);
        }
        if (papaJohns.size() == 0){
            System.out.println("Papa Johns: No ratings yet");
        }
        else{
            System.out.printf("Papa Johns: %.2f\n", ratingAvgPapa);
        }
        if (dominos.size() == 0){
            System.out.println("Dominos: No ratings yet");
        }
        else{
            System.out.printf("Dominos: %.2f\n", ratingAvgPapa);
        }
    }
    /**
     * this method prints the reviews for each pizza place
     */
    public static void printReviews(ArrayList<Integer> cuginoFornoRating,
                                    ArrayList<Integer> papaJohnsRating,
                                    ArrayList<Integer> dominosRating,
                                    ArrayList<String> cuginoFornoReview,
                                    ArrayList<String> papaJohnsReview,
                                    ArrayList<String> dominosReview) {
        int i;

        System.out.println("Cugino Forno");
        if (cuginoFornoRating.size() == 0){
            System.out.println("No ratings yet");
        }
        else {
            for (i = 0; i < cuginoFornoRating.size(); ++i) {
                System.out.println("Rating: " + cuginoFornoRating.get(i) + "\nReview: " + cuginoFornoReview.get(i));
            }
        }
        System.out.println();

        System.out.println("Papa Johns");
        if (papaJohnsRating.size() == 0){
            System.out.println("No ratings yet");
        }
        else{
            for (i = 0; i < papaJohnsRating.size(); ++i) {
                System.out.println("Rating: " + papaJohnsRating.get(i) + "\nReview: " + papaJohnsReview.get(i));
            }
        }
        System.out.println();

        System.out.println("Dominos");
        if (dominosRating.size() == 0){
            System.out.println("No ratings yet");
        }
        else{
            for (i = 0; i < dominosRating.size(); ++i) {
                System.out.println("Rating: " + dominosRating.get(i) + "\nReview: " + dominosReview.get(i));
            }
        }
        System.out.println();
    }
    /**
     * this method prints the topRating for each pizza place as long as there is a rating for each pizza place
     */
    public static void topRating(ArrayList<Integer> cuginoForno,
                                 ArrayList<Integer> papaJohns,
                                 ArrayList<Integer> dominos) {
        int i;
        double ratingAvgPapa = 0;
        double ratingAvgDomino = 0;
        double ratingAvgCugino = 0;


        for (i = 0; i < cuginoForno.size(); ++i) {
            ratingAvgCugino += cuginoForno.get(i);
        }
        ratingAvgCugino = ratingAvgCugino / cuginoForno.size();

        for (i = 0; i < papaJohns.size(); ++i) {
            ratingAvgPapa += papaJohns.get(i);
        }
        ratingAvgPapa = ratingAvgPapa / papaJohns.size();


        for (i = 0; i < dominos.size(); ++i) {
            ratingAvgDomino += dominos.get(i);
        }

        ratingAvgDomino = ratingAvgDomino / dominos.size();


        if (papaJohns.size() == 0 && dominos.size() == 0 && cuginoForno.size() == 0){
            System.out.print("");
        }
        else if (ratingAvgPapa > ratingAvgDomino){
            if (ratingAvgPapa > ratingAvgCugino) {
                System.out.println("Papa Johns has the highest rating with a " + ratingAvgPapa);
            }
            else {
                System.out.println("Papa Johns and Cugino Furno have the highest rating with a " + ratingAvgPapa);
            }
        }
        else if (ratingAvgDomino > ratingAvgCugino){
            if(ratingAvgDomino > ratingAvgPapa) {
                System.out.println("Dominos has the highest rating with a " + ratingAvgDomino);
            }
            else {
                System.out.println("Dominos and Papa Johns have the highest rating with a " + ratingAvgDomino);
            }
        }
        else if (ratingAvgCugino > ratingAvgPapa){
            if(ratingAvgCugino > ratingAvgDomino){
                System.out.println("Cugino Forno has the highest rating with a " + ratingAvgCugino);
            }
            else {
                System.out.println("Dominos and Cugino Furno have the highest rating with a " + ratingAvgDomino);
            }
        }
        else if (ratingAvgPapa == ratingAvgDomino && ratingAvgPapa == ratingAvgCugino){
            System.out.println("All pizza places have the same rating with a " + ratingAvgCugino);
        }

    }
}

