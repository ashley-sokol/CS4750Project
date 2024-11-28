package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.Rating;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RatingRepository extends JpaRepository<Rating, Integer> {
    List<Rating> findByMovieId(int movieId);

    List<Rating> findByUserId(long userId);

    Rating findByUserIdAndMovieId(long userId, int movieId);

    List<Rating> findByShowId(int showId);
}
