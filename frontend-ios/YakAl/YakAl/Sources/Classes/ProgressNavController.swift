//
//  ProgressNavController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/14.
//

import UIKit

class ProgressNavController: UINavigationController, UINavigationControllerDelegate {
    
    private let outerView = UIView()
    private let innerView = UIView()
    private var pctConstraint: NSLayoutConstraint!
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Color
        innerView.backgroundColor = UIColor(red: 0.333, green: 0.533, blue: 0.992, alpha: 1.0)
        outerView.backgroundColor = UIColor(red: 0.945, green: 0.961, blue: 0.996, alpha: 1.0)

        outerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.translatesAutoresizingMaskIntoConstraints = false

        outerView.addSubview(innerView)

        // Initialize pctConstraint
        pctConstraint = innerView.widthAnchor.constraint(equalTo: outerView.widthAnchor, multiplier: .leastNonzeroMagnitude)

        let leadingConstraint = innerView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor)
        leadingConstraint.priority = .defaultHigh

        let trailingConstraint = innerView.trailingAnchor.constraint(equalTo: outerView.trailingAnchor)
        trailingConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            // Inner view top
            innerView.topAnchor.constraint(equalTo: outerView.topAnchor),
            // Inner view leading
            leadingConstraint,
            // Inner view bottom
            innerView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor),
            // Inner view width
            pctConstraint,
        ])

        self.delegate = self
    }


    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        // if the next VC to show
        //    is a MyBaseVC subclass
        if let _ = viewController as? SignInViewController {
            
            // add the "progess view" if we're coming from a non-MyBaseVC controller
            if outerView.superview == nil {
                
                view.addSubview(outerView)
                
                let g = view.safeAreaLayoutGuide
                NSLayoutConstraint.activate([
                    
                    
                    // top
                    outerView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 24.0),
                    
                    // leading
                    outerView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 145.0),
                    
                    // trailing
                    outerView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -145.0),
                    
                    // height
                    outerView.heightAnchor.constraint(equalToConstant: 6.0),
                    
                ])
                
                // .alpha to Zero so we can "fade it in"
                outerView.alpha = 0.0
                
                // we just added the progress view,
                //    so we'll let didShow "fade it in"
                //    and update the progress width
                
            } else {
                
                self.updateProgress(viewController)

            }
            
        } else {
            
            if outerView.superview != nil {
                // we want to quickly "fade-out" and remove the "progress view"
                //    if the next VC to show
                //    is NOT a MyBaseVC subclass
                UIView.animate(withDuration: 0.1, animations: {
                    self.outerView.alpha = 0.0
                }, completion: { _ in
                    self.outerView.removeFromSuperview()
                    self.pctConstraint.isActive = false
                    self.pctConstraint = self.innerView.widthAnchor.constraint(equalTo: self.outerView.widthAnchor, multiplier: .leastNonzeroMagnitude)
                    self.pctConstraint.isActive = true
                })
            }
            
        }
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        // if the VC just shown
        //    is a MyBaseVC subclass
        //    AND
        //    outerView.alpha < 1.0 (meaning it was just added)
        if let _ = viewController as? SignInViewController, outerView.alpha < 1.0 {
            self.updateProgress(viewController)
        }
        
        // otherwise, updateProgress() is called from willShow

    }
    
    private func updateProgress(_ viewController: UIViewController) {
        
        if let vc = viewController as? SignInViewController {
            
            // update the innerView width -- the "progress"
            let nSteps: CGFloat = CGFloat(vc.numSteps)
            let thisStep: CGFloat = CGFloat(vc.myStepNumber)
            var pct: CGFloat = .leastNonzeroMagnitude
            
            // sanity check
            //    avoid error/crash if either values are Zero
            if nSteps > 0.0, thisStep > 0.0 {
                pct = thisStep / nSteps
            }
            
            // don't exceed 100%
            pct = min(pct, 1.0)
            
            // we can't update the multiplier directly, so
            //    deactivate / update / activate
            self.pctConstraint.isActive = false
            self.pctConstraint = self.innerView.widthAnchor.constraint(equalTo: self.outerView.widthAnchor, multiplier: pct, constant: -8.0)
            self.pctConstraint.isActive = true
            
            // if .alpha is already 1.0, this is effectively ignored
            UIView.animate(withDuration: 0.1, animations: {
                self.outerView.alpha = 1.0
            })
            
            // animate the "bar width"
            UIView.animate(withDuration: 0.3, animations: {
                self.outerView.layoutIfNeeded()
            })

        }

    }
    
}
