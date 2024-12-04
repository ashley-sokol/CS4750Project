package com.example.moviereviewzproject.controller;

import com.example.moviereviewzproject.model.Rating;
import com.example.moviereviewzproject.repository.RatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/ratings")
public class RatingController {

    @Autowired
    private RatingRepository ratingRepository;
    @PostMapping
    public ResponseEntity<Rating> createRating(@RequestBody Rating rating) {
        // Check if the user has already rated the movie
        Rating existingRating = ratingRepository.findByUserIdAndMovieId(rating.getUser().getUserID(), rating.getMovie().getMovieId());
        if (existingRating != null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        Rating createdRating = ratingRepository.save(rating);
        return new ResponseEntity<>(createdRating, HttpStatus.CREATED);
    }
    @GetMapping
    public ResponseEntity<List<Rating>> getAllRatings() {
        List<Rating> ratings = ratingRepository.findAll();
        if (ratings.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(ratings, HttpStatus.OK);
    }
    @GetMapping("/movie/{movieId}")
    public ResponseEntity<List<Rating>> getRatingsByMovie(@PathVariable("movieId") int movieId) {
        List<Rating> ratings = ratingRepository.findByMovieId(movieId);
        if (ratings.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(ratings, HttpStatus.OK);
    }
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Rating>> getRatingsByUser(@PathVariable("userId") long userId) {
        List<Rating> ratings = ratingRepository.findByUserId(userId);
        if (ratings.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(ratings, HttpStatus.OK);
    }
    @GetMapping("/{id}")
    public ResponseEntity<Rating> getRatingById(@PathVariable("id") int id) {
        Optional<Rating> rating = ratingRepository.findById(id);
        return rating.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
    @PutMapping("/{id}")
    public ResponseEntity<Rating> updateRating(@PathVariable("id") int id, @RequestBody Rating updatedRating) {
        Optional<Rating> existingRatingOpt = ratingRepository.findById(id);
        if (existingRatingOpt.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        Rating existingRating = existingRatingOpt.get();
        existingRating.setRatingValue(updatedRating.getRatingValue());
        Rating savedRating = ratingRepository.save(existingRating);
        return new ResponseEntity<>(savedRating, HttpStatus.OK);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deleteRating(@PathVariable("id") int id) {
        try {
            if (ratingRepository.existsById(id)) {
                ratingRepository.deleteById(id);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/movie/{movieId}/average")
    public ResponseEntity<Double> getAverageRating(@PathVariable("movieId") int movieId) {
        Double averageRating = ratingRepository.findAverageRatingByMovieId(movieId);
        if (averageRating == null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(averageRating, HttpStatus.OK);
    }
}
