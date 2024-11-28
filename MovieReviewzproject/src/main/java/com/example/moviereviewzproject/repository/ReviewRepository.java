package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReviewRepository extends JpaRepository<Review, Integer> {
    List<Review> findByMovieId(int movieId);

    List<Review> findByUserId(long userId);

    List<Review> findByMovieIdAndUserId(int movieId, long userId);
}
