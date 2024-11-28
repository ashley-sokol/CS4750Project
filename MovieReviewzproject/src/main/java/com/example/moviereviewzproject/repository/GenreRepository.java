package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.Genre;
import com.example.moviereviewzproject.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface GenreRepository extends JpaRepository<Genre, Integer> {
    Genre findByName(String name);
    List<Genre> findByDescriptionContaining(String description);
    @Query("SELECT m FROM Movie m WHERE m.genre.id = ?1")
    List<Movie> findMoviesByGenreId(int genreId);
    @Query("SELECT m FROM Movie m WHERE m.genre.name = ?1")
    List<Movie> findMoviesByGenreName(String genreName);
}
