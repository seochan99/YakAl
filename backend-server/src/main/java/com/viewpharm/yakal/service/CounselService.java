package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Counsel;
import com.viewpharm.yakal.domain.Note;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.NoteRequestDto;
import com.viewpharm.yakal.dto.response.NoteDetailDto;
import com.viewpharm.yakal.dto.response.PatientDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.CounselRepository;
import com.viewpharm.yakal.repository.NoteRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class CounselService {
    private final UserRepository userRepository;
    private final CounselRepository counselRepository;
    private final NoteRepository noteRepository;

    public Boolean createCounsel(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //환자 확인
        User patient = userRepository.findByIdAndJob(patientId, EJob.PATIENT).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PATIENT));

        //상담 중복 확인
        counselRepository.findByExpertAndPatient(expert, patient)
                .ifPresent(c -> {
                    throw new CommonException(ErrorCode.DUPLICATION_COUNSEL);
                });

        counselRepository.save(Counsel.builder()
                .expert(expert)
                .patient(patient)
                .build());

        return Boolean.TRUE;
    }

    public Boolean deleteCounsel(Long expertId, Long counselId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        Counsel counsel = counselRepository.findByIdAndIsDeleted(counselId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNSEL));

        //상담 전문가와 요청 전문가 비교
        if (counsel.getExpert().getId() != expert.getId())
            throw new CommonException(ErrorCode.NOT_EQUAL);

        counsel.deleteCounsel();

        return Boolean.TRUE;
    }

    public List<PatientDto> getPatientList(Long expertId, Long pageIndex, Long pageSize) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        Pageable paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "createDate"));

        List<Counsel> counselList = counselRepository.findByExpertIdAndIsDeleted(expertId, false, paging);

        List<PatientDto> patientDtoList = new ArrayList<>();

        for (Counsel counsel : counselList) {
            User patient = userRepository.findByIdAndJob(counsel.getPatient().getId(), EJob.PATIENT)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PATIENT));
            patientDtoList.add(PatientDto.builder()
                    .id(patient.getId())
                    .name(patient.getName())
                    .sex(patient.getSex())
                    .birthday(patient.getBirthday())
                    .build());
            //테스트 퍼센트, 약 수 추가 예정
            //추가 후 방식 바꿀 예정
        }
        return patientDtoList;
    }

    public Boolean createNote(Long expertId, Long patientId, Long counselId, NoteRequestDto requestDto) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //환자 확인
        User patient = userRepository.findByIdAndJob(patientId, EJob.PATIENT).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PATIENT));

        //상담 확인
        Counsel counsel = counselRepository.findByIdAndIsDeleted(counselId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNSEL));

        //입력값 유효성 확인
        if ((requestDto.getTitle().length() == 0) || (requestDto.getDescription().length() == 0)) {
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);
        }

        noteRepository.save(Note.builder()
                .title(requestDto.getTitle())
                .description(requestDto.getDescription())
                .counsel(counsel)
                .build()
        );

        return Boolean.TRUE;
    }

    //특이사항 자세히 읽어야 하는지?
    public NoteDetailDto updateNote(Long expertId, Long noteId, NoteRequestDto requestDto) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        Note note = noteRepository.findByIdAndIsDeleted(noteId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTE));

        noteRepository.findByIdNotAndTitleAndIsDeleted(noteId, requestDto.getTitle(), false)
                .ifPresent(c -> {
                    throw new CommonException(ErrorCode.DUPLICATION_TITLE);
                });

        //입력값 유효성 확인
        if ((requestDto.getTitle().length() == 0) || (requestDto.getDescription().length() == 0)) {
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);
        }

        //상담 전문가와 요쳥 전문가 비교
        if (note.getCounsel().getExpert().getId() != expert.getId())
            throw new CommonException(ErrorCode.NOT_EQUAL);

        //수정
        note.modifyNote(requestDto.getTitle(), requestDto.getDescription());

        return NoteDetailDto.builder()
                .id(note.getId())
                .title(note.getTitle())
                .description(note.getDescription())
                .build();
    }

    public Boolean deleteNote(Long expertId, Long counselId, Long noteId) {
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //상담 확인
        Counsel counsel = counselRepository.findByIdAndIsDeleted(counselId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNSEL));


        Note note = noteRepository.findByIdAndIsDeleted(noteId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTE));

        //상담 전문가와 요쳥 전문가 비교
        if (note.getCounsel().getExpert().getId() != expert.getId())
            throw new CommonException(ErrorCode.NOT_EQUAL);

        note.deleteNote();

        return Boolean.TRUE;
    }


    public List<NoteDetailDto> getAllNoteList(Long expertId, Long counselId, Long pageIndex, Long pageSize) {
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //상담 확인
        Counsel counsel = counselRepository.findByIdAndIsDeleted(counselId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNSEL));

        Pageable paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "createDate"));

        List<Note> noteList = noteRepository.findByCounselAndIsDeleted(counsel, false, paging);

        List<NoteDetailDto> list = noteList.stream()
                .map(n -> new NoteDetailDto(n.getId(), n.getTitle(), n.getDescription()))
                .collect(Collectors.toList());
        return list;
    }
}
