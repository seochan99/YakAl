package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.common.annotation.UserId;
import com.viewpharm.yakal.dto.request.CreatePrescriptionDto;
import com.viewpharm.yakal.dto.response.PrescriptionDto;
import com.viewpharm.yakal.base.ResponseDto;
import com.viewpharm.yakal.service.PrescriptionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/prescription")
public class PrescriptionController {

    private final PrescriptionService prescriptionService;

    @GetMapping("")
    public ResponseDto<List<PrescriptionDto>> getPrescriptions(
            @UserId Long id) {
        return ResponseDto.ok(prescriptionService.getPrescriptions(id));
    }

    @PostMapping("")
    public ResponseDto<Boolean> createPrescription(
            @UserId Long id, @RequestBody CreatePrescriptionDto prescriptionDto){

        return ResponseDto.ok(prescriptionService.createPrescription(id,prescriptionDto));
    }


}
