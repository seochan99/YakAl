package com.viewpharm.yakal.prescription.controller;

import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.prescription.dto.request.CreatePrescriptionDto;
import com.viewpharm.yakal.prescription.dto.response.PrescriptionDto;
import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.prescription.service.PrescriptionService;
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
