package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Counsel;
import com.viewpharm.yakal.domain.Note;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

//특이 사항 삭제 예정
@Deprecated
@Repository
public interface NoteRepository extends JpaRepository<Note, Long> {
    Optional<Note> findByIdAndIsDeleted(Long noteId, Boolean isDeleted);

    Optional<Note> findByIdNotAndTitleAndIsDeleted(Long noteId, String title, Boolean isDeleted);

    Page<Note> findByCounselAndIsDeleted(Counsel counsel, Boolean isDeleted, Pageable pageable);

}
