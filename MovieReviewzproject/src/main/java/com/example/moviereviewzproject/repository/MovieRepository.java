package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface MovieRepository extends JpaRepository<Movie, Integer> {
    List<Movie> findByTitleContainingIgnoreCase(String title);
    @Query("SELECT m FROM Movie m WHERE m.genre.name = ?1")
    List<Movie> findByGenreName(String genreName);
    @Query("SELECT m FROM Movie m WHERE m.director.name = ?1")
    List<Movie> findByDirectorName(String directorName);
    List<Movie> findByMaturityRating(String maturityRating);
    @Query("SELECT m FROM Movie m WHERE m.rating = ?1")
    List<Movie> findByRating(Double rating);
    @Query("SELECT m FROM Movie m WHERE m.genre.id = ?1")
    List<Movie> findByGenreId(Integer genreId);
    List<Movie> findByDescriptionContainingIgnoreCase(String description);
}
