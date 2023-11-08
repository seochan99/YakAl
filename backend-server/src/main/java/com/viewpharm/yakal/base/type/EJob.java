package com.viewpharm.yakal.base.type;

public enum EJob {
    PATIENT,
    DOCTOR,
    PHARMACIST;

    // EJob to ERole
    public ERole toEole() {
        switch (this) {
            case PATIENT -> {
                return ERole.USER;
            }
            case DOCTOR -> {
                return ERole.DOCTOR;
            }
            case PHARMACIST -> {
                return ERole.PHARMACIST;
            }
            default -> {
                assert (false) : "Invalid Type Error";
            }
        }

        return null;
    }
}
