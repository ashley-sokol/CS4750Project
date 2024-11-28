package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.Genre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GenreRepository extends JpaRepository<Genre, Integer> {
    Genre findByName(String name);
    List<Genre> findByDescriptionContaining(String description);
    List<Movie> findByGenreId(int genreId);
    @Query("SELECT m FROM Movie m WHERE m.genre.name = ?1")
    List<Movie> findMoviesByGenreName(String genreName);
}
