<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;

use App\Entity\User;
use App\Form\RegisterType;

//Cargar el encode para cifrar la contraseñas
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

//cargar para autentificacion de login
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class UserController extends AbstractController
{

    public function register(Request $request, UserPasswordEncoderInterface $encoder)
    {
        
        //Crear el formulario
        $user = new User();
        $form = $this->createForm(RegisterType::class, $user);
        
        //Rellenar el objeto con los datos del form
        $form->handleRequest($request);
        
        //Comprobar si el formulario se ha enviado
        if($form->isSubmitted() && $form->isValid()){
            //modificar el objeto para guardarlo
            $user->setRole('ROLE_USER');
            
            //guardar la fecha
            $user->setCreatedAt(new \DateTime('now'));
           
            //Cifrar Contraseña
            $encoded = $encoder->encodePassword($user, $user->getPassword());
            $user->setPassword($encoded);
           
            //Guardar Usuario
            $em = $this->getDoctrine()->getManager();
            $em->persist($user);
            $em->flush();
            
            return $this->redirectToRoute('tasks');
        }
        
        return $this->render('user/register.html.twig', [
            'form' => $form->createView()
        ]);
    }
    
    public function login(AuthenticationUtils $authenticationUtils){
        $error = $authenticationUtils->getLastAuthenticationError();
        
        $lastUsername = $authenticationUtils->getLastUsername();
        
        return $this->render('user/login.html.twig', array(
            'error' => $error,
            'last_username' => $lastUsername
        ));
    }
}
