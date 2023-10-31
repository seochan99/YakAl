package com.viewpharm.yakal.base.utils;

import org.springframework.stereotype.Component;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

@Component
public class RsaUtil {

    private static final String ALGORITHM = "RSA";
    private static final int KEY_SIZE = 2048;

    public KeyPair generateKeypair() throws NoSuchAlgorithmException {
        final KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(ALGORITHM);
        keyPairGenerator.initialize(KEY_SIZE, new SecureRandom());

        return keyPairGenerator.generateKeyPair();
    }

    public PublicKey convertToPublicKey(final String publicKey)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        assert (publicKey != null && !publicKey.isEmpty()) : "Invalid String PublicKey";

        final KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        final byte[] publicKeyByte = Base64.getDecoder().decode(publicKey.getBytes());

        return keyFactory.generatePublic(new X509EncodedKeySpec(publicKeyByte));

    }

    public PrivateKey convertToPrivateKey(final String privateKey)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        assert (privateKey != null && !privateKey.isEmpty()) : "Invalid String PublicKey";

        final KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        final byte[] privateKeyByte = Base64.getDecoder().decode(privateKey.getBytes());

        return keyFactory.generatePrivate(new PKCS8EncodedKeySpec(privateKeyByte));

    }

    public String rsaEncode(final String plainText, final String publicKey)
            throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeySpecException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        assert (publicKey != null && !publicKey.isEmpty()) : "Invalid String PublicKey";
        assert (plainText != null && !plainText.isEmpty()) : "Invalid PlainText";

        final Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, convertToPublicKey(publicKey));
        final byte[] plainTextByte = cipher.doFinal(plainText.getBytes());

        return base64Encode(plainTextByte);
    }

    public String rsaDecode(final String encryptedPlainText, final String privateKey)
            throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeySpecException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        assert (privateKey != null && !privateKey.isEmpty()) : "Invalid String PrivateKey";
        assert (encryptedPlainText != null && !encryptedPlainText.isEmpty()) : "Invalid Encrypted Plain Text";

        final byte[] encryptedPlainTextByte = base64Decode(encryptedPlainText);

        final Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, convertToPublicKey(privateKey));

        return new String(cipher.doFinal(encryptedPlainTextByte));
    }

    public String base64Encode(final byte[] bytes) {
        return Base64.getEncoder().encodeToString(bytes);
    }

    public byte[] base64Decode(final String str) {
        return Base64.getDecoder().decode(str);
    }
}
