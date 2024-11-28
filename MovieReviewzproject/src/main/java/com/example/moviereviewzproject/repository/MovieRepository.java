package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MovieRepository extends JpaRepository<Movie, Integer> {
    List<Movie> findByTitleContainingIgnoreCase(String title);
    @Query("SELECT m FROM Movie m WHERE m.genre.name = ?1")
    List<Movie> findByGenreName(String genreName);
    @Query("SELECT m FROM Movie m WHERE m.director.name = ?1")
    List<Movie> findByDirectorName(String directorName);
    List<Movie> findByMaturityRating(String maturityRating);
}
