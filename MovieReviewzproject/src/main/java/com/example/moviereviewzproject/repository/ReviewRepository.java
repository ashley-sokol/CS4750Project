package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Integer> {
    List<Review> findByMovieId(int movieId);
    List<Review> findByUserId(long userId);
    List<Review> findByMovieIdAndUserId(int movieId, long userId);
    @Query("SELECT r FROM Review r WHERE LOWER(r.text) LIKE LOWER(CONCAT('%', ?1, '%'))")
    List<Review> findByTextContainingIgnoreCase(String text);
}
